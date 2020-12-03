//
//  Remedy.swift
//  Healthera
//
//  Created by Kashan Qamar on 02/12/2020.
//

import Foundation

struct Remedy: Decodable {
    let data: [remedyData]
}

struct remedyData : Codable {
    let patient_id : String
    let remedy_id : String
    let medicine_name : String
    let instruction : String
    let schedule : [Schedule]?
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patient_id = try values.decode(String.self, forKey: .patient_id)
        remedy_id = try values.decodeIfPresent(String.self, forKey: .remedy_id) ?? ""
        medicine_name = try values.decodeIfPresent(String.self, forKey: .medicine_name) ?? ""
        instruction = try values.decodeIfPresent(String.self, forKey: .instruction) ?? ""
        schedule = try values.decodeIfPresent(Array.self, forKey: .schedule) ?? []

        }
}

struct Schedule : Codable {
    let day_iterator : Int
    let alarm_window : Int
    let dose_min : Int
    let dose_max : Int

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day_iterator = try values.decode(Int.self, forKey: .day_iterator) 
        alarm_window = try values.decodeIfPresent(Int.self, forKey: .alarm_window) ?? 0
        dose_min = try values.decodeIfPresent(Int.self, forKey: .dose_min) ?? 0
        dose_max = try values.decodeIfPresent(Int.self, forKey: .dose_max) ?? 0
                
        }

}



extension Remedy {
    static func remedyDataRequest(remidyId:String, patientId:String) -> Request<Remedy> {
        return Request(method: .get, path: "/patients/\(String(describing: UserDefaults.standard.string(forKey: "userID") ?? ""))/remedies/\(remidyId)", pars: [:])
    }
}
