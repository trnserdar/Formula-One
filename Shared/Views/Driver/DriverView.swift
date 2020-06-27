//
//  DriverView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI
import URLImage

struct DriverView: View {
    
    var driver: DriverModel
    var teams: [DriverTeamModel] {
        
        guard let teams = driver.teams else {
            return []
        }
        
        return teams
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ScrollView(.vertical) {
                
                DriverPersonalView(driver: self.driver)
                
                ForEach((0..<self.teams.count), id: \.self) { index in
                    DriverSeasonView(team: self.teams[index])
                }
            }
            .navigationBarTitle(self.driver.name)
        }
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView(driver: DriverModel(id: 25, name: "Max Verstappen", image: "https://media.api-sports.io/formula-1/drivers/25.png", nationality: "Dutch", birthdate: "1997-09-30", teams: [DriverTeamModel(season: 2019, team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil)),
                                                                                                                                                                                             
                                                                                                                                                                                                 DriverTeamModel(season: 2018, team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil))]))
        }
}
