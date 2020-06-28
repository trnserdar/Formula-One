//
//  CircuitsView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

class CircuitStore: ObservableObject {
    
    @Published var circuits: [CircuitModel] = []
    
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

struct CircuitsView: View {
    
    @StateObject private var store = CircuitStore()
    
    var body: some View {
        
        GeometryReader { geo in
            
            NavigationView {
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach((0..<self.store.circuits.count), id: \.self) { index in
                        
                            NavigationLink(destination: CircuitView(circuit: self.store.circuits[index])) {
                                CircuitView(circuit: self.store.circuits[index])
                            }
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                            .background(Color.white)
                        }
                    }
                }
                .accentColor(.black)
                .onAppear(perform: self.store.getCircuits)
                .navigationBarTitle(Text("Circuits"), displayMode: .large)
            }
        }
    }
}

struct CircuitsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircuitsView()
//            CircuitsView()
//                .preferredColorScheme(.dark)
//            CircuitsView()
//                .previewDevice("iPad (7th generation)")
        }
    }
}
