//
//  CircuitsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct CircuitsView: View {
    
    @State private var circuits: [CircuitModel] = [CircuitModel(id: 1, name: "Albert Park", image: "https://media.api-sports.io/formula-1/circuits/1.png", competition: CompetitionModel(id: 1, name: "Australia Grand Prix", location: LocationModel(country: "Australia", city: "Melbourne")), length: "5.303 Kms", capacity: 80000, opened: 1953, owner: nil), CircuitModel(id: 1, name: "Albert Park", image: "https://media.api-sports.io/formula-1/circuits/1.png", competition: CompetitionModel(id: 1, name: "Australia Grand Prix", location: LocationModel(country: "Australia", city: "Melbourne")), length: "5.303 Kms", capacity: 80000, opened: 1953, owner: nil), CircuitModel(id: 1, name: "Albert Park", image: "https://media.api-sports.io/formula-1/circuits/1.png", competition: CompetitionModel(id: 1, name: "Australia Grand Prix", location: LocationModel(country: "Australia", city: "Melbourne")), length: "5.303 Kms", capacity: 80000, opened: 1953, owner: nil)]
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            NavigationView {
                            
                List(self.circuits, id: \.id) { circuit in
                    
                    NavigationLink(destination: CircuitView(circuit: circuit)) {
                        CircuitView(circuit: circuit)
                    }
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                    .background(Color.white)
                }
                .onAppear(perform: self.getCircuits)
                .navigationBarTitle(Text("Circuits"), displayMode: .large)
            }
        }
        
    }
    
    func getCircuits() {
        
        FormulaOneClient.getCircuits(search: nil) { (response, error) in
            
            guard error == nil else {
                print("getCircuits error: \(error!)")
                return
            }
            
            guard let response = response,
                let list = response.response else {
                print("getCircuits empty")
                return
            }
            
            DispatchQueue.main.async {
                self.circuits = list
            }
        }
        
    }
}

struct CircuitsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircuitsView()
            CircuitsView()
                .preferredColorScheme(.dark)
            CircuitsView()
                .previewDevice("iPad (7th generation)")
        }
    }
}
