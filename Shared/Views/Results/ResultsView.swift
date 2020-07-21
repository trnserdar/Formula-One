//
//  ResultsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct ResultConfig {
    
    var seasons: [Int] = []
    var selectedSeason: Int = 2020
    
    var competitions: [CompetitionModel] = []
    var selectedCompetitionIndex: Int = 0
    
    var races: [RaceModel] = []
    var selectedRaceIndex: Int = 0
    
    var rankings: [RankingModel] = []
    var isShowRankDetail = false
}

struct ResultsView: View {
    
    @State private var resultConfig = ResultConfig()
    
    var body: some View {
        
        let selectedSeasonBinding = Binding<Int>(
            get: {
                self.resultConfig.selectedSeason
            },
            set: {
                self.resultConfig.selectedSeason = $0
                self.getRaces()
                print("Selected Competition: \(self.resultConfig.competitions[self.resultConfig.selectedCompetitionIndex].name), \(self.resultConfig.selectedSeason)")
            }
        )
        
        let selectedCompetitionBinding = Binding<Int>(
            get: {
                self.resultConfig.selectedCompetitionIndex
            },
            set: {
                self.resultConfig.selectedCompetitionIndex = $0
                self.getRaces()
                print("Selected Competition: \(self.resultConfig.competitions[self.resultConfig.selectedCompetitionIndex].name), \(self.resultConfig.selectedSeason)")
            }
        )
        
        let selectedRaceBinding = Binding<Int>(
            get: {
                self.resultConfig.selectedRaceIndex
            },
            set: {
                self.resultConfig.selectedRaceIndex = $0
                print("Selected Race: \(self.resultConfig.selectedRaceIndex)")
            }
        )
        
        return GeometryReader { geo in
            
            NavigationView {
                
                ZStack {
                    
                    if self.resultConfig.races.count > self.resultConfig.selectedRaceIndex &&
                        self.resultConfig.rankings.count > 0 {
                        NavigationLink(destination: RaceRankingsView(selectedRace: self.resultConfig.races[self.resultConfig.selectedRaceIndex], rankings: self.resultConfig.rankings), isActive: self.$resultConfig.isShowRankDetail) { EmptyView().hidden().opacity(0.0) }
                    }
                    
                    Form {
                        
                        Section {
                            
                            Picker("Season", selection: selectedSeasonBinding) {
                                ForEach(self.resultConfig.seasons, id: \.self) { season in
                                    Text("\(String(format: "%2d", season))")
                                    .font(.customSubheadline)
                                }
                                
                            }.font(.customSubheadline)
                        }
                        
                        Section {
                            
                            Picker("Competitions", selection: selectedCompetitionBinding) {
                                ForEach((0..<self.resultConfig.competitions.count), id: \.self) { index in
                                    Text("\(self.resultConfig.competitions[index].name)")
                                    .font(.customSubheadline)
                                }
                                
                            }.font(.customSubheadline)
                        }
                        
                        if self.resultConfig.races.count > 0 {
                            
                            Section {
                                
                                Picker("Races", selection: selectedRaceBinding) {
                                    ForEach((0..<self.resultConfig.races.count), id: \.self) { index in
                                        Text("\(self.resultConfig.races[index].type ?? "Unknown")")
                                        .font(.customSubheadline)
                                    }
                                    
                                }.font(.customSubheadline)
                            }
                        }
                        
                        Section {
                            
                            Button(action: {
                                
                                if self.resultConfig.races.count > 0 {
                                    self.getRaceRankings()
                                } else {
                                    self.getRaces()
                                }
                                
                            }, label: {
                                Text("Get Results!")
                                    .font(.customSubheadline)
                                    .foregroundColor(.officialColor)
                            })
                            .frame(width: geo.size.width - 20, height: 40.0, alignment: .center)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8.0)
                            .padding(2.0)
                        }
                        .listRowInsets(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: -10.0))
                    }

                }
                .onAppear(perform: self.getSeasons)
                .onAppear(perform: self.getCompetitions)
                .navigationTitle(Text("Results"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func getSeasons() {
        
        guard resultConfig.seasons.count == 0 else {
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
                self.resultConfig.seasons = list
            }
            
            print("Seasons Count: \(list.count)")
        }
    }
    
    func getCompetitions() {
        
        guard resultConfig.competitions.count == 0 else {
            return
        }
        
        FormulaOneClient.getCompetitions(search: nil) { (response, error) in
            
            guard error == nil else {
                print("getCompetitions error: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("getCompetitions empty")
                return
            }
            
            print("Competitions Count: \(list.count)")
            DispatchQueue.main.async {
                self.resultConfig.competitions = list
            }
        }
    }
    
    func getRaces() {
        
        guard resultConfig.competitions.count > resultConfig.selectedCompetitionIndex else {
            return
        }
        
        self.resultConfig.races.removeAll()
                
        FormulaOneClient.getRaces(competition: resultConfig.competitions[resultConfig.selectedCompetitionIndex].id, season: resultConfig.selectedSeason) { (response, error) in
            
            guard error == nil else {
                print("getRaces error: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("getRaces empty")
                return
            }
            
            print("Races Count: \(list.count)")
            DispatchQueue.main.async {
                self.resultConfig.races = list
            }
        }
    }
    
    func getRaceRankings() {
        
        guard resultConfig.races.count > resultConfig.selectedRaceIndex else {
            return
        }
        
        FormulaOneClient.getRaceRankings(race: resultConfig.races[resultConfig.selectedRaceIndex].id) { (response, error) in
            
            guard error == nil else {
                print("getRaceRankings: error \(error!.localizedDescription)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("getRaceRankings empty")
                return
            }
            
            DispatchQueue.main.async {
                self.resultConfig.rankings = list
                self.resultConfig.isShowRankDetail = true
            }
        }
    }
    
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
