//
//  FormulaOneRouter.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation
import Alamofire

// MARK: - FormulaOneRouter
enum FormulaOneRouter: URLRequestConvertible {
    
    // MARK: - URL
    static let baseURLPath = NetworkConstants.baseURL
    
    // MARK: - Instance Properties
    case seasons
    case rankings(type: String, season: Int)
    case competitions(search: String?)
    case teams(search: String?)
    case drivers(search: String)
    case circuits(search: String?)
    case races(competition: Int, season: Int)
    case raceRankings(race: Int)
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
            case .seasons, .rankings, .competitions, .teams, .drivers, .circuits, .races, .raceRankings:
                return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .seasons:
            return "/seasons"
        case .rankings(type: let type, season: _):
            return "/rankings/\(type)"
        case .competitions:
            return "/competitions"
        case .teams:
            return "/teams"
        case .drivers:
            return "/drivers"
        case .circuits:
            return "/circuits"
        case .races:
            return "/races"
        case .raceRankings:
            return "/rankings/races"
        }
    }
    
    // MARK: - Parameters
    var parameters: [String: Any] {
        
        switch self {
        case .rankings(type: _, season: let season):
            return ["season": season]
        case .teams(search: let search):
            return search != nil ? ["search": search!] : [:]
        case .competitions(search: let search):
            return search != nil ? ["search": search!] : [:]
        case .drivers(search: let search):
            return ["search": search]
        case .circuits(search: let search):
            return search != nil ? ["search": search!] : [:]
        case .races(competition: let competition, season: let season):
            return ["competition": competition, "season": season]
        case .raceRankings(race: let race):
            return ["race": race]
        default:
            return [:]
        }
    }
    
    // MARK: - URLRequest
    public func asURLRequest() throws -> URLRequest {
                
        let url = try FormulaOneRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 20
        
        request.addValue("api-formula-1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(NetworkConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
