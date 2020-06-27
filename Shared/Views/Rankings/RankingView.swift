//
//  RankingView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI
import URLImage

struct RankingView: View {

    var ranking: RankingModel
    var rankingType: String // drivers, teams, races
    
    var imageURL: URL {
        
        if (rankingType == "drivers" || rankingType == "races"),
            self.ranking.driver != nil,
            self.ranking.driver!.image != nil,
            let url = URL(string: self.ranking.driver!.image!) {
            return url
        }
        
        if rankingType == "teams",
            self.ranking.team != nil,
            self.ranking.team!.logo != nil,
            let url = URL(string: self.ranking.team!.logo!) {
            return url
        }
        
        return URL(string: "https://media.api-sports.io/formula-1")!
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            HStack {
                
                VStack(alignment: .center, spacing: 5) {
                    Text("\(self.ranking.position)")
                        .font(.customHeadline)
                }
                .padding(10.0)
                
                URLImage(self.imageURL, placeholder: { _ in
                    Text("Loading...")
                        .font(.customBody)
                    
                }) { proxy in
                    proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.red.opacity(0.2), lineWidth: 2))
                }
                .padding(10)
                .frame(maxWidth: 100.0, maxHeight: 100.0)
                
                VStack(alignment: .center, spacing: 8) {
                    
                    if self.rankingType == "drivers" || self.rankingType == "races" {
                        
                        Text("\(self.ranking.driver?.name ?? "Unknown")")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)

                        Text("\(self.ranking.team?.name ?? "Unknown")")
                            .font(.customSubheadline)
                            .foregroundColor(.officialColor)
                            .multilineTextAlignment(.center)
                        
                    } else if self.rankingType == "teams" {
                        
                        Text("\(self.ranking.team?.name ?? "Unknown")")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(5.0)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    
                    if self.rankingType == "drivers" || self.rankingType == "teams" {
                        Text("\(self.ranking.points ?? 0) pt")
                            .font(.customHeadline)
                    } else if self.rankingType == "races" {
                        Text("\(self.ranking.time ?? "")")
                            .font(.customCaption)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(15.0)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16.0)
            .padding(EdgeInsets(top: 5.0, leading: 10.0, bottom: 5.0, trailing: 10.0))
        }
        
    }

    
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(ranking: RankingModel(position: 1, team: TeamModel(id: 5, name: "Mercedes-AMG Petronas", logo: "https://media.api-sports.io/formula-1/teams/5.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil), points: 413, season: 2019, driver: DriverModel(id: 20, name: "Lewis Hamilton", image: "https://media.api-sports.io/formula-1/drivers/20.png", nationality: nil, birthdate: nil, teams: nil), wins: 11, behind: 0, race: nil, time: nil, laps: nil, grid: nil, pits: nil, gap: nil), rankingType: "drivers")
    }
}
