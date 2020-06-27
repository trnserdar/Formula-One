//
//  RaceModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct RaceModel: Codable, Identifiable {
    
    var id: Int
    var competition: CompetitionModel?
    var circuit: CircuitModel?
    var season: Int?
    var type: String?
    var laps: LapModel?
    var distance: String?
    var timezone: String?
    var date: String?
    var weather: String?
    var status: String?
}
