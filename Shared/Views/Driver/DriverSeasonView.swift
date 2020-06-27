//
//  DriverSeasonView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI
import URLImage

struct DriverSeasonView: View {
    
    var team: DriverTeamModel
    
    var body: some View {
        
        VStack {
            
            HStack {

                VStack(alignment: .center, spacing: 7) {
                    Text("Season")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(String(format: "%2d", self.team.season))")
                        .font(.customHeadline)

                }
                .padding(10.0)
                
                URLImage(URL(string: self.team.team?.logo ?? "https://media.api-sports.io/formula-1")!, placeholder: { _ in
                    Text("Loading...")
                        .font(.customBody)
                    
                }) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.red.opacity(0.2), lineWidth: 2))
                }
                .frame(width: 80.0, height: 80.0, alignment: .center)
                .clipShape(Circle())
                .padding(10)
                
                Text("\(self.team.team?.name ?? "Unknown")")
                    .font(.customHeadline)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16.0)
        .padding(EdgeInsets(top: 5, leading: 10.0, bottom: 5, trailing: 10.0))
    }
}

struct DriverSeasonView_Previews: PreviewProvider {
    static var previews: some View {
        DriverSeasonView(team: DriverTeamModel(season: 2018, team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil)))
    }
}
