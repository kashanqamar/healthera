//
//  UserDefaults.swift
//  Healthera
//
//  Created by Kashan Qamar on 01/12/2020.
//

import Foundation


extension UserDefaults{
    
    //MARK: Set Token
    func setUserToken(value: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: "token")
        synchronize()
    }

    func getUserToken()-> String {
        return String(UserDefaults.standard.string(forKey: "token") ?? "")
    }

    //MARK: Save User Data
    func setUserID(value: String){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: "userID")
        synchronize()
    }

    //MARK: Retrieve User Data
    func getUserID() -> String{
        return String(UserDefaults.standard.string(forKey: "userID") ?? "")
    }
    
    
    //MARK: Save User forename
    func setUserForname(value: String){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: "forename")
        synchronize()
    }

    //MARK: Retrieve User forename
    func getUserForname() -> String{
        return String(UserDefaults.standard.string(forKey: "forename") ?? "")
    }
    
    //MARK: Save User surname
    func setUserSurname(value: String){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: "surname")
        synchronize()
    }

    //MARK: Retrieve User surname
    func getUserSurname() -> String{
        return String(UserDefaults.standard.string(forKey: "surname") ?? "")
    }
    
    //MARK: reset
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        synchronize()
    }
    
    
}


