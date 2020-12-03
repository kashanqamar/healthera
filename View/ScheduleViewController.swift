//
//  ScheduleViewController.swift
//  Healthera
//
//  Created by Kashan Qamar on 02/12/2020.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var scheduledDateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var adherenceData : [adherenceData] = []
    var remidyData : [remedyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = UIColor.systemGreen
        openLoginScreen()
    }
    
    // MARK: - check if usere is log in or not
    func openLoginScreen() {
                
        if(UserDefaults.standard.getUserToken() != ""){
            self.setupUI()
            self.fetchData()
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginModel") as? LoginViewController
            vc?.modalPresentationStyle = .fullScreen
            vc?.didSelectItem = { [weak self](tokenData) in
                        if let _ = self {
                            print("Login ", tokenData.data.first?.token ?? "")
                            UserDefaults.standard.setUserToken(value: tokenData.data.first?.token ?? "")
                            UserDefaults.standard.setUserID(value: tokenData.aux.tokenPayload.user_id)
                            UserDefaults.standard.setUserForname(value: tokenData.data.first?.user.forename ?? "")
                            UserDefaults.standard.setUserSurname(value: tokenData.data.first?.user.surname ?? "")
                            self?.fetchData()
                        }
                    }
            self.present(vc!, animated: false) {
                
            print("successfully validated")
        }
        }
    }

    
    // MARK:- Setup UI
    @objc func setupUI() {
        self.userNameLabel.text = UserDefaults.standard.getUserSurname() + ", " + UserDefaults.standard.getUserForname()
        let date = Date(timeIntervalSince1970: (self.adherenceData.first?.alarm_time ?? 0.0 / 1000.0))
        self.scheduledDateLabel.text = date.toString(dateFormat: "EEEE, MMMM dd")
    }
    
    
    // MARK: - Fetch Adherence Data
    @objc func fetchData() {
        APIManager.shared.execute(Adherence.adherenceDataRequest()) { [weak self] result in

            switch result {
            case .success(let adherenceData):
                DispatchQueue.main.async {
                    self?.adherenceData = adherenceData.data
                    self?.fetchRemidyData(remidyId: adherenceData.data.first?.remedy_id ?? "", patientId: adherenceData.data.first?.patient_id ?? "")
                    print(adherenceData.data.first?.remedy_id ?? "")
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showError()
                }
            }
        }
    }
    
    // MARK: - fetch remidy data
    func fetchRemidyData(remidyId:String, patientId:String){
        APIManager.shared.execute(Remedy.remedyDataRequest(remidyId: remidyId, patientId: patientId)) { [weak self] result in

            switch result {
            case .success(let remidyData):
                DispatchQueue.main.async {
                    print(remidyData)
                    self?.remidyData = remidyData.data
                    self?.tableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showError()
                }
            }
        }
    }
    
    //MARK: - logout
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.resetDefaults()
        openLoginScreen()
    }
   

    
    // MARK: - Display service error
    func showError() {
        let alertController = UIAlertController(title: "", message: LocalizedString(key: "login.load.error.body"), preferredStyle: .alert)
        let alertAction = UIAlertAction(title: LocalizedString(key: "login.load.error.actionButton"), style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}


// MARK: - UITableViewDataSource
extension ScheduleViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.remidyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath) as! MedicineTableViewCell        
        cell.descriptionLabel.text! = self.remidyData[indexPath.row].medicine_name + "," + self.remidyData[indexPath.row].instruction
        return cell
    }
    
}

// MARK: - UITableViewControllerDelegate
extension ScheduleViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
