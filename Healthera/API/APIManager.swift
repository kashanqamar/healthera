//
//  APIManager.swift
//  Healthera
//
//  Created by Kashan Qamar on 29/11/2020.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIError: Error {
    case networkError
    case parsingError
}

extension URL {
    func url(with queryItems: [URLQueryItem]) -> URL {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)!        
        return components.url!
    }
    
    init<Value>(_ host: String, _ apiKey: String, _ request: Request<Value>) {
        let queryItems = [ ("", "") ]
            .map { name, value in URLQueryItem(name: name, value: "\(value)") }
        
        
        let url = URL(string: host)!
            .appendingPathComponent(request.path)
            .url(with: queryItems)
        
        self.init(string: url.absoluteString)!
    }
}

final class APIManager {
    
    static let shared = APIManager()
    
    let host = "https://api.84r.co"
    let apiKey = "mzUFOsQJLESdYOY"
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func execute<Value: Decodable>(_ request: Request<Value>, completion: @escaping (Result<Value, APIError>) -> Void) {
            
        urlSession.dataTask(with: urlRequest(for: request)) { responseData, response, error in
            if let data = responseData {
                let response: Value
                do {
                    response = try JSONDecoder().decode(Value.self, from: data) 
                } catch {
                    completion(.failure(.parsingError))
                    return
                }
                completion(.success(response))
            } else {
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    private func urlRequest<Value>(for request: Request<Value>) -> URLRequest {
        let url = URL(host, apiKey, request)
        
        var result = URLRequest(url: url)

        if url.absoluteString.range(of: "/tokens") != nil {
        // insert json data to the request
            let json: [String: String] =  request.queryParams
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            result.httpBody = jsonData
        }
//
        result.setValue("application/json", forHTTPHeaderField: "Content-Type")
        result.setValue("application/json", forHTTPHeaderField: "Accept")
        result.setValue(apiKey, forHTTPHeaderField: "client-id")
        result.httpMethod = request.method.rawValue
                
        result.setValue("iOS", forHTTPHeaderField: "app-platform")
        result.setValue("1.4", forHTTPHeaderField: "app-version")
        result.setValue(String(describing: UserDefaults.standard.string(forKey: "token") ?? ""), forHTTPHeaderField: "Token")
        
        
        return result
    }
    
}

