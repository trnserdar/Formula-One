//
//  RankingModel.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation

struct RankingModel: Codable, Identifiable {
    
    var id = UUID()
    var position: Int
    var team: TeamModel?
    var points: Int?
    var season: Int?
    var driver: DriverModel?
    var wins: Int?
    var behind: Int?
    var race: RaceModel?
    var time: String?
    var laps: Int?
    var grid: String?
    var pits: Int?
    var gap: String?
    
    enum CodingKeys: CodingKey {
        case position
        case team
        case points
        case season
        case driver
        case wins
        case behind
        case race
        case time
        case laps
        case grid
        case pits
        case gap
    }
    
    init(position: Int, team: TeamModel?, points: Int, season: Int, driver: DriverModel?, wins: Int?, behind: Int?, race: RaceModel?, time: String?, laps: Int?, grid: String?, pits: Int?, gap: String?) {
        self.position = position
        self.team = team
        self.points = points
        self.season = season
        self.driver = driver
        self.wins = wins
        self.behind = behind
        self.race = race
        self.time = time
        self.laps = laps
        self.grid = grid
        self.pits = pits
        self.gap = gap
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        position = try values.decode(Int.self, forKey: .position)
        team = try values.decodeIfPresent(TeamModel.self, forKey: .team)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        season = try values.decodeIfPresent(Int.self, forKey: .season)
        driver = try values.decodeIfPresent(DriverModel.self, forKey: .driver)
        wins = try values.decodeIfPresent(Int.self, forKey: .wins)
        behind = try values.decodeIfPresent(Int.self, forKey: .behind)
        race = try values.decodeIfPresent(RaceModel.self, forKey: .race)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        laps = try values.decodeIfPresent(Int.self, forKey: .laps)
        grid = try values.decodeIfPresent(String.self, forKey: .grid)
        pits = try values.decodeIfPresent(Int.self, forKey: .pits)
        gap = try values.decodeIfPresent(String.self, forKey: .gap)
    }

    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(position, forKey: .position)
        try container.encode(team, forKey: .team)
        try container.encode(points, forKey: .points)
        try container.encode(season, forKey: .season)
        try container.encode(driver, forKey: .driver)
        try container.encode(wins, forKey: .wins)
        try container.encode(behind, forKey: .behind)
        try container.encode(race, forKey: .race)
        try container.encode(time, forKey: .time)
        try container.encode(laps, forKey: .laps)
        try container.encode(grid, forKey: .grid)
        try container.encode(pits, forKey: .pits)
        try container.encode(gap, forKey: .gap)
    }
    
}
