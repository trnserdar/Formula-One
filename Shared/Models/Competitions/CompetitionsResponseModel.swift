//
//  CompetitionsResponseModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct CompetitionsResponseModel: Codable {
   
    var get: String?
    var results: Int?
    var response: [CompetitionModel]?
    
}
