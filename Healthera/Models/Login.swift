//
//  Login.swift
//  Healthera
//
//  Created by Kashan Qamar on 29/11/2020.
//

import Foundation

struct Login: Decodable {
    
    let data: [Data]
    let aux: Aux
    
}

struct Data : Codable {
    let token : String
    let user : User
}

struct User : Codable {
    let forename : String
    let surname : String
}


struct Aux : Codable {
        let tokenPayload : TokenPayload
}

struct TokenPayload : Codable {
        let user_id : String
}


extension Login {
    static func tokenDetails(userEmail:String, userPasswrod:String) -> Request<Login> {
        return Request(method: .post, path: "/tokens", pars: ["username":userEmail, "user_password":userPasswrod])
    }
}
