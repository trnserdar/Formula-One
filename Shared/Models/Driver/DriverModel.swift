//
//  DriverModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct DriverModel: Codable, Identifiable {
    
    var id: Int
    var name: String
    var image: String?
    var nationality: String?
    var birthdate: String?
    var teams: [DriverTeamModel]?
    
}
