//
//  FormulaOneClient.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation
import Alamofire

class FormulaOneClient: ServiceClient {
    
    public static func getSeasons(completion: @escaping (_ response: SeasonsResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.seasons, decodingType: SeasonsResponseModel.self, completion: completion)
    }
    
    public static func getRankings(type: String, season: Int, completion: @escaping (_ response: RankingsResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.rankings(type: type, season: season), decodingType: RankingsResponseModel.self, completion: completion)
    }
    
    public static func getCompetitions(search: String?, completion: @escaping (_ response: CompetitionsResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.competitions(search: search), decodingType: CompetitionsResponseModel.self, completion: completion)
    }
    
    public static func getTeams(search: String?, completion: @escaping (_ response: TeamsResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.teams(search: search), decodingType: TeamsResponseModel.self, completion: completion)
    }
    
    public static func getDrivers(search: String, completion: @escaping (_ response: DriversResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.drivers(search: search), decodingType: DriversResponseModel.self, completion: completion)
    }
    
    public static func getCircuits(search: String?, completion: @escaping (_ response: CircuitsResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.circuits(search: search), decodingType: CircuitsResponseModel.self, completion: completion)
    }
    
    public static func getRaces(competition: Int, season: Int, completion: @escaping (_ response: RacesResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.races(competition: competition, season: season), decodingType: RacesResponseModel.self, completion: completion)
    }
    
    public static func getRaceRankings(race: Int, completion: @escaping (_ response: RankingsResponseModel?, _ error: Error?) -> Void) {
        makeRequest(route: FormulaOneRouter.raceRankings(race: race), decodingType: RankingsResponseModel.self, completion: completion)
    }
}


