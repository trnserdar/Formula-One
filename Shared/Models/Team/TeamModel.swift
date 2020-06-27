//
//  TeamModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct TeamModel: Codable, Identifiable {
    
    var id: Int
    var name: String
    var logo: String?
    var president: String?
    var director: String?
    var technical_manager: String?
    var engine: String?
    var tyres: String?
    
}
