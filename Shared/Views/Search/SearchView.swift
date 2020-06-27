//
//  SearchView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchKey = ""
    @State private var drivers: [DriverModel] = []
    @State private var teams: [TeamModel] = []
    @State private var circuits: [CircuitModel] = []
    
    var body: some View {

         let searchKeyBinding = Binding<String>(
             get: {
                 self.searchKey
             },
             set: {
                 self.searchKey = $0
                
                guard self.searchKey.count > 2 else {
                    
                    if self.searchKey.count == 0 {
                        self.clearData()
                    }
                    
                    return
                }
                
                self.clearData()
                self.getDrivers()
                self.getTeams()
                self.getCircuits()
             }
         )
        
        return GeometryReader { geo in
            
            NavigationView {
                
                Form {
                    
                    Section {
                        TextField("Search", text: searchKeyBinding) {
                            UIApplication.shared.endEditing()
                        }
                    }
                    
                    Section {
                        
                        List {
                            
                            if self.drivers.count > 0 {
                                Section(header: Text("Drivers")
                                    .font(.customHeadline)
                                    .foregroundColor(.officialColor)
                                ) {
                                    ForEach((0..<self.drivers.count), id: \.self) { index in
                                        
                                        NavigationLink(destination: DriverView(driver: self.drivers[index])) {
                                            Text("\(self.drivers[index].name)")
                                            .font(.customSubheadline)
                                        }
                                    }
                                }
                            }
                            
                            if self.teams.count > 0 {
                                Section(header: Text("Teams")
                                    .font(.customHeadline)
                                    .foregroundColor(.officialColor)
                                ) {
                                    ForEach((0..<self.teams.count), id: \.self) { index in
                                        
                                        NavigationLink(destination: TeamView(team: self.teams[index])) {
                                            Text("\(self.teams[index].name)")
                                                .font(.customSubheadline)
                                        }
                                    }
                                }
                            }
                            
                            if self.circuits.count > 0 {
                                Section(header: Text("Circuits")
                                    .font(.customHeadline)
                                    .foregroundColor(.officialColor)
                                ) {
                                    ForEach((0..<self.circuits.count), id: \.self) { index in
                                        
                                        NavigationLink(destination: CircuitView(circuit: self.circuits[index])) {
                                            Text("\(self.circuits[index].name)")
                                                .font(.customSubheadline)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
                .navigationBarTitle(Text("Search"), displayMode: .large)
            }
        }
        
    }
    
    func clearData() {
        
        DispatchQueue.main.async {
            self.drivers = []
            self.teams = []
            self.circuits = []
        }
    }
    
    func getDrivers() {
                
        FormulaOneClient.getDrivers(search: searchKey) { (response, error) in
            
            guard error == nil else {
                print("Error get drivers: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("Error get drivers limit")
                return
            }
            
            DispatchQueue.main.async {
                self.drivers = list
            }
        }
    }
    
    func getTeams() {
        
        FormulaOneClient.getTeams(search: searchKey) { (response, error) in
            
            guard error == nil else {
                print("Error get teams: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("Error get teams limit")
                return
            }
            
            DispatchQueue.main.async {
                self.teams = list
            }
        }
    }
    
    func getCircuits() {
        
        FormulaOneClient.getCircuits(search: searchKey) { (response, error) in
            
            guard error == nil else {
                print("Error get circuits: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("Error get circuits limit")
                return
            }
            
            DispatchQueue.main.async {
                self.circuits = list
            }
        }
    }
    
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
