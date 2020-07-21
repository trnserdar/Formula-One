//
//  TeamsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 28.06.2020.
//

import SwiftUI

class TeamStore: ObservableObject {
    
    @Published var teams: [TeamModel] = []
    
    func getTeams() {
        
        FormulaOneClient.getTeams(search: nil) { (response, error) in
            
            guard error == nil else {
                
                print("getTeams error: \(error!.localizedDescription)")
                return
            }
            
            guard let response = response,
                  let list = response.response else {
                print("getTeams empty")
                return
            }
            
            DispatchQueue.main.async {
                self.teams = list
            }
        }
    }
}

struct TeamsView: View {
    
    @StateObject private var store = TeamStore()
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        
        GeometryReader { geo in
           
            NavigationView {
                
                ScrollView {
                    
                    LazyVGrid(columns: columns, spacing: 5.0) {
                     
                        ForEach((0..<self.store.teams.count), id: \.self) { index in
                            
                            NavigationLink(destination: TeamView(team: self.store.teams[index])) {
                                TeamItemView(team: self.store.teams[index])
                                    .background(Color.white)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                    }
                    .accentColor(.black)
                    .onAppear(perform: store.getTeams)
                    .navigationTitle(Text("Teams"))
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
