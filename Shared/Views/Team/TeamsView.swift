//
//  TeamsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 28.06.2020.
//

import SwiftUI

struct TeamsView: View {
    
    @State private var teams: [TeamModel] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        
        GeometryReader { geo in
           
            NavigationView {
                
                ScrollView {
                    
                    LazyVGrid(columns: columns, spacing: 5.0) {
                     
                        ForEach((0..<self.teams.count), id: \.self) { index in
                            
                            NavigationLink(destination: TeamView(team: self.teams[index])) {
                                TeamItemView(team: self.teams[index])
                                    .background(Color.white)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                    }
                    .accentColor(.black)
                    .onAppear(perform: self.getTeams)
                    .navigationBarTitle(Text("Teams"), displayMode: .large)
                }
            }
        }
    }
    
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

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
