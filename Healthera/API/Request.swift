//
//  Request.swift
//  Healthera
//
//  Created by Kashan Qamar on 29/11/2020.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

struct Request<Value> {
    
    var method: Method
    var path: String
    var queryParams: [String: String]
    
    init(method: Method = .get, path: String, pars: [String: String]) {
        self.method = method
        self.path = path
        self.queryParams = pars
    }
    
}

