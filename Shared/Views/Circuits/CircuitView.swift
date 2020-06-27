//
//  CircuitView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI
import URLImage

struct CircuitView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var circuit: CircuitModel
    
    var body: some View {

        GeometryReader { geo in
            
            VStack(alignment: .center) {
                
                HStack(alignment: .top, spacing: 20) {
                    
                    VStack(alignment: .center, spacing: 7) {
                        Text("Country")
                            .font(.customHeadline)
                            .foregroundColor(Color.officialColor)
                        Text("\(self.circuit.competition?.location?.country ?? "Unknown")")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)
                    }.padding(5.0)
                                        
                    VStack(alignment: .center, spacing: 7) {
                        Text("City")
                            .font(.customHeadline)
                            .foregroundColor(Color.officialColor)
                        Text("\(self.circuit.competition?.location?.city ?? "Unknown")")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)
                    }.padding(5.0)
                    
                }
                .padding(15.0)
                
                Spacer()
                
                URLImage(URL(string: self.circuit.image!)!, placeholder: { _ in
                    Text("Loading...")
                        .font(.customBody)
                    
                }) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                }

                .frame(minWidth: geo.size.width - 10, maxWidth: geo.size.width, alignment: .center)
                .padding(5.0)
                .background(colorScheme == .dark ? Color.officialColor
                                .opacity(0.2).cornerRadius(16.0)
                                : Color.clear.cornerRadius(16.0))

                Spacer()

                HStack(alignment: .top) {
                    
                    VStack(alignment: .center, spacing: 7) {
                        Text("Circuit Name")
                            .font(.customHeadline)
                            .foregroundColor(Color.officialColor)
                        Text("\(self.circuit.name)")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)
                    }.padding(5.0)
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 7) {
                        Text("Length")
                            .font(.customHeadline)
                            .foregroundColor(Color.officialColor)
                        Text("\(self.circuit.length ?? "Unknown")")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)
                    }.padding(5.0)
                    
                    Spacer()

                    VStack(alignment: .center, spacing: 7) {
                        Text("Owner")
                            .font(.customHeadline)
                            .foregroundColor(Color.officialColor)
                        Text("\(self.circuit.owner ?? "Unknown")")
                            .font(.customHeadline)
                            .multilineTextAlignment(.center)
                    }.padding(5.0)
                }
                .padding(15.0)
                .frame(maxWidth: .infinity)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16.0)
            .frame(minWidth: geo.size.width, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
    }
}

struct CircuitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircuitView(circuit: CircuitModel(id: 1, name: "Albert Park", image: "https://media.api-sports.io/formula-1/circuits/1.png", competition: CompetitionModel(id: 1, name: "Australia Grand Prix", location: LocationModel(country: "Australia", city: "Melbourne")), length: "5.303 Kms", capacity: 80000, opened: 1953, owner: nil))
            CircuitView(circuit: CircuitModel(id: 1, name: "Albert Park", image: "https://media.api-sports.io/formula-1/circuits/1.png", competition: CompetitionModel(id: 1, name: "Australia Grand Prix", location: LocationModel(country: "Australia", city: "Melbourne")), length: "5.303 Kms", capacity: 80000, opened: 1953, owner: nil))
                .preferredColorScheme(.dark)
        }
    }
}
