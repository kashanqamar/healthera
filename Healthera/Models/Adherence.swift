//
//  Adherence.swift
//  Healthera
//
//  Created by Kashan Qamar on 02/12/2020.
//

import Foundation


struct Adherence: Decodable {
    let data: [adherenceData]
}

struct adherenceData : Codable {
    let patient_id : String
    let remedy_id : String
    let token : String
    let alarm_time : Double
    let adherence_id : String
    let action : String
    let action_time : Double
    let dose_discrete : String
    let dose_quantity : Double
    let note : String
    let date_modified : String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patient_id = try values.decode(String.self, forKey: .patient_id)
        remedy_id = try values.decodeIfPresent(String.self, forKey: .remedy_id) ?? ""
        token = try values.decodeIfPresent(String.self, forKey: .token) ?? ""
        alarm_time = try values.decodeIfPresent(Double.self, forKey: .alarm_time) ?? 0.0
        adherence_id = try values.decodeIfPresent(String.self, forKey: .adherence_id) ?? ""
        action = try values.decodeIfPresent(String.self, forKey: .action) ?? ""
        action_time = try values.decodeIfPresent(Double.self, forKey: .action_time) ?? 0.0
        dose_discrete = try values.decodeIfPresent(String.self, forKey: .dose_discrete) ?? ""
        dose_quantity = try values.decodeIfPresent(Double.self, forKey: .dose_quantity) ?? 0.0
        note = try values.decodeIfPresent(String.self, forKey: .note) ?? ""
        date_modified = try values.decodeIfPresent(String.self, forKey: .date_modified) ?? ""
                
        }
    
    
}

extension Adherence {
    static func adherenceDataRequest() -> Request<Adherence> {
        return Request(method: .get, path: "/patients/\(String(describing: UserDefaults.standard.string(forKey: "userID") ?? ""))/adherences", pars: [:])
    }
}
