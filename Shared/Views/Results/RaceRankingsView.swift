//
//  RaceRankingsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct RaceRankingsView: View {
    
    var selectedRace: RaceModel
    var rankings: [RankingModel]
    
    var body: some View {

        GeometryReader { geo in
            
            List {
                ForEach(self.rankings) { ranking in
                    RankingView(ranking: ranking, rankingType: "races")
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: .infinity, minHeight: 120, maxHeight: .infinity)
                        .background(Color.white)
                }
            }
            .background(Color.clear)
            .navigationTitle(Text("\(self.selectedRace.competition?.name ?? "")"))
        }

    }
}

struct RaceRankingsView_Previews: PreviewProvider {
    static var previews: some View {
        RaceRankingsView(selectedRace: RaceModel(id: 1, competition: nil, circuit: nil, season: nil, type: nil, laps: nil, distance: nil, timezone: nil, date: nil, weather: nil, status: nil), rankings: [])
    }
}
