//
//  LoginViewController.swift
//  Healthera
//
//  Created by Kashan Qamar on 29/11/2020.
//


import UIKit
import TextFieldEffects
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet var loginEmailTextfield: TextFieldEffects!
    @IBOutlet var loginPasswordTextfield: TextFieldEffects!
    var didSelectItem: ((_ tokenData: Login) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    @IBAction func performLogin(_ sender: UIButton) {
        fetchData()
    }
    
    @IBAction func performresetPassword(_ sender: UIButton) {
                
    }
    
  
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func setup(){
        self.loginEmailTextfield.delegate = self
        self.loginPasswordTextfield.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
                
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func fetchData() {
        
        APIManager.shared.execute(Login.tokenDetails(userEmail: self.loginEmailTextfield.text!, userPasswrod: self.loginPasswordTextfield.text!)) { [weak self] result in
            switch result {
            case .success(let tokenData):
                DispatchQueue.main.async {
                    self?.didSelectItem(tokenData)
                    self?.dismiss(animated: true, completion: nil)
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showError()
                }
            }
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "", message: LocalizedString(key: "login.load.error.body"), preferredStyle: .alert)
        let alertAction = UIAlertAction(title: LocalizedString(key: "login.load.error.actionButton"), style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

    
    


