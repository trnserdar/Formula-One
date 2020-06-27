//
//  RankingsResponseModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct RankingsResponseModel: Codable {
   
    var get: String?
    var results: Int?
    var response: [RankingModel]?
    
}
