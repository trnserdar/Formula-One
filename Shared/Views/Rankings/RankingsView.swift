//
//  RankingsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct RankingsView: View {
    
    @State var seasons: [Int] = []
    @State private var selectedSeason = 2019
    
    var types: [String] = ["Drivers", "Teams"]
    @State private var selectedType = "Drivers"
    
//    [RankingModel(position: 1, team: TeamModel(id: 5, name: "Mercedes-AMG Petronas", logo: "https://media.api-sports.io/formula-1/teams/5.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil), points: 413, season: 2019, driver: DriverModel(id: 20, name: "Lewis Hamilton", image: "https://media.api-sports.io/formula-1/drivers/20.png", nationality: nil, birthdate: nil, teams: nil), wins: 11, behind: 0, race: nil, time: nil, laps: nil, grid: nil, pits: nil, gap: nil), RankingModel(position: 1, team: TeamModel(id: 5, name: "Mercedes-AMG Petronas", logo: "https://media.api-sports.io/formula-1/teams/5.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil), points: 413, season: 2019, driver: DriverModel(id: 20, name: "Lewis Hamilton", image: "https://media.api-sports.io/formula-1/drivers/20.png", nationality: nil, birthdate: nil, teams: nil), wins: 11, behind: 0, race: nil, time: nil, laps: nil, grid: nil, pits: nil, gap: nil)]
    @State private var rankings: [RankingModel] = []
    
    var body: some View {
        
        let selectedSeasonBinding = Binding<Int>(
            get: {
                self.selectedSeason
            },
            set: {
                self.selectedSeason = $0
                self.getRankings()
                print("set selected season: \(self.selectedSeason)")
            }
        )
        
        let selectedTypeBinding = Binding<String>(
            get: {
                self.selectedType
            },
            set: {
                self.selectedType = $0
                self.getRankings()
                print("set selected type: \(self.selectedType)")
            }
        )
       
        return GeometryReader { geo in
            
            NavigationView {
                
                Form {
                    Section {
                        Picker("Selected Season", selection: selectedSeasonBinding) {
                            ForEach(self.seasons, id: \.self) { season in
                                Text("\(String(format: "%2d", season))")
                                .font(.customSubheadline)
                            }
                            
                        }.font(.customSubheadline)
                    }
                    
                    Section {
                        
                        Picker("Ranking Type:", selection: selectedTypeBinding) {
                            ForEach(self.types, id: \.self) { type in
                                Text("\(type)")
                                .font(.customSubheadline)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .font(.customSubheadline)
                    }
                    
                    Section {
                        List {
                            ForEach(self.rankings) { ranking in
                                RankingView(ranking: ranking, rankingType: self.selectedType.lowercased())
                                    .listRowInsets(EdgeInsets())
                                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: .infinity)
                                    .background(Color.white)
                            }
        
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                }
                .onAppear(perform: self.getSeasons)
                .onAppear(perform: self.getRankings)
                .navigationBarTitle(Text("Rankings"), displayMode: .large)
            }
        }
    }
    
    func getSeasons() {
        
        guard seasons.count == 0 else {
            return
        }
        
        FormulaOneClient.getSeasons { (response, error) in
            
            guard error == nil else {
                print("getSeasons error: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("getSeasons empty")
                return
            }
            
            DispatchQueue.main.async {
                self.seasons = list
            }
            
            print("Seasons Count: \(list.count)")
        }
        
    }
    
    func getRankings() {
        
        FormulaOneClient.getRankings(type: selectedType.lowercased(), season: selectedSeason) { (response, error) in
        
             guard error == nil else {
                print("get rankings error: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("get rankings")
                return
            }
            
            DispatchQueue.main.async {
                self.rankings = list
            }
        }
    }
    

    
    
}

struct RankingsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingsView()
    }
}
