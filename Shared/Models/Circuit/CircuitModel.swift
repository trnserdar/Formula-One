//
//  CircuitModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct CircuitModel: Codable, Identifiable {
    
    var id: Int
    var name: String
    var image: String?
    var competition: CompetitionModel?
    var length: String?
    var capacity: Int?
    var opened: Int?
    var owner: String?
    
}
