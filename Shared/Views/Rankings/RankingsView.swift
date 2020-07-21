//
//  RankingsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

class RankingConfig: ObservableObject {
    
    @Published var seasons: [Int] = []
    @Published var selectedSeason = 2020
    
    var types: [String] = ["Drivers", "Teams"]
    @Published var selectedType = "Drivers"
    
    @Published var rankings: [RankingModel] = []
}

struct RankingsView: View {
    
    @ObservedObject private var config = RankingConfig()
    
    var body: some View {
        
        let selectedSeasonBinding = Binding<Int>(
            get: {
                self.config.selectedSeason
            },
            set: {
                self.config.selectedSeason = $0
                self.getRankings()
                print("set selected season: \(self.config.selectedSeason)")
            }
        )
        
        let selectedTypeBinding = Binding<String>(
            get: {
                self.config.selectedType
            },
            set: {
                self.config.selectedType = $0
                self.getRankings()
                print("set selected type: \(self.config.selectedType)")
            }
        )
       
        return GeometryReader { geo in
            
            NavigationView {
                
                Form {
                    Section {
                        Picker("Selected Season", selection: selectedSeasonBinding) {
                            ForEach(self.config.seasons, id: \.self) { season in
                                Text("\(String(format: "%2d", season))")
                                .font(.customSubheadline)
                            }
                            
                        }.font(.customSubheadline)
                    }
                    
                    Section {
                        
                        Picker("Ranking Type:", selection: selectedTypeBinding) {
                            ForEach(self.config.types, id: \.self) { type in
                                Text("\(type)")
                                .font(.customSubheadline)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .font(.customSubheadline)
                    }
                    
                    Section {
                        List {
                            ForEach(self.config.rankings) { ranking in
                                RankingView(ranking: ranking, rankingType: self.config.selectedType.lowercased())
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
                .navigationTitle(Text("Rankings"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func getSeasons() {
        
        guard config.seasons.count == 0 else {
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
                self.config.seasons = list
            }
            
            print("Seasons Count: \(list.count)")
        }
        
    }
    
    func getRankings() {
        
        FormulaOneClient.getRankings(type: config.selectedType.lowercased(), season: config.selectedSeason) { (response, error) in
        
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
                self.config.rankings = list
            }
        }
    }
    

    
    
}

struct RankingsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingsView()
    }
}
