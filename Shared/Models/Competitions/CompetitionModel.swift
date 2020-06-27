//
//  CompetitionModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct CompetitionModel: Codable, Identifiable {
    
    var id: Int
    var name: String
    var location: LocationModel?
    
}
