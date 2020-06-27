//
//  ResultsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct ResultsView: View {
    
    @State var seasons: [Int] = []
    @State private var selectedSeason: Int = 2019
    
    @State private var competitions: [CompetitionModel] = []
    @State private var selectedCompetitionIndex: Int = 0
    
    @State private var races: [RaceModel] = []
    @State private var selectedRaceIndex: Int = 0
    
    @State private var rankings: [RankingModel] = []
    @State private var isShowRankDetail = false
    
    var body: some View {
        
        let selectedSeasonBinding = Binding<Int>(
            get: {
                self.selectedSeason
            },
            set: {
                self.selectedSeason = $0
                self.getRaces()
                print("Selected Competition: \(self.competitions[self.selectedCompetitionIndex].name), \(self.selectedSeason)")
            }
        )
        
        let selectedCompetitionBinding = Binding<Int>(
            get: {
                self.selectedCompetitionIndex
            },
            set: {
                self.selectedCompetitionIndex = $0
                self.getRaces()
                print("Selected Competition: \(self.competitions[self.selectedCompetitionIndex].name), \(self.selectedSeason)")
            }
        )
        
        let selectedRaceBinding = Binding<Int>(
            get: {
                self.selectedRaceIndex
            },
            set: {
                self.selectedRaceIndex = $0
                print("Selected Race: \(self.selectedRaceIndex)")
            }
        )
        
        return GeometryReader { geo in
            
            NavigationView {
                
                ZStack {
                    
                    if self.races.count > self.selectedRaceIndex &&
                        self.rankings.count > 0 {
                        NavigationLink(destination: RaceRankingsView(selectedRace: self.races[self.selectedRaceIndex], rankings: self.rankings), isActive: self.$isShowRankDetail) { EmptyView().hidden().opacity(0.0) }
                    }
                    
                    Form {
                        
                        Section {
                            
                            Picker("Season", selection: selectedSeasonBinding) {
                                ForEach(self.seasons, id: \.self) { season in
                                    Text("\(String(format: "%2d", season))")
                                    .font(.customSubheadline)
                                }
                                
                            }.font(.customSubheadline)
                        }
                        
                        Section {
                            
                            Picker("Competitions", selection: selectedCompetitionBinding) {
                                ForEach((0..<self.competitions.count), id: \.self) { index in
                                    Text("\(self.competitions[index].name)")
                                    .font(.customSubheadline)
                                }
                                
                            }.font(.customSubheadline)
                        }
                        
                        if self.races.count > 0 {
                            
                            Section {
                                
                                Picker("Races", selection: selectedRaceBinding) {
                                    ForEach((0..<self.races.count), id: \.self) { index in
                                        Text("\(self.races[index].type ?? "Unknown")")
                                        .font(.customSubheadline)
                                    }
                                    
                                }.font(.customSubheadline)
                            }
                        }
                        
                        Section {
                            
                            Button(action: {
                                
                                if self.races.count > 0 {
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
                .navigationBarTitle(Text("Results"), displayMode: .large)
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
    
    func getCompetitions() {
        
        guard competitions.count == 0 else {
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
                self.competitions = list
            }
        }
    }
    
    func getRaces() {
        
        guard competitions.count > selectedCompetitionIndex else {
            return
        }
        
        self.races.removeAll()
                
        FormulaOneClient.getRaces(competition: competitions[selectedCompetitionIndex].id, season: selectedSeason) { (response, error) in
            
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
                self.races = list
            }
        }
    }
    
    func getRaceRankings() {
        
        guard races.count > selectedRaceIndex else {
            return
        }
        
        FormulaOneClient.getRaceRankings(race: races[selectedRaceIndex].id) { (response, error) in
            
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
                self.rankings = list
                self.isShowRankDetail = true
            }
        }
    }
    
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
