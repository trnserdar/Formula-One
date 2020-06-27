//
//  TeamView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI
import URLImage

struct TeamView: View {

    var team: TeamModel
    
    var imageURL: URL {
        
        guard team.logo != nil,
            let url = URL(string: team.logo!) else {
            return URL(string: "https://media.api-sports.io/formula-1")!
        }
    
        return url
    }
    
    var body: some View {
        
        VStack {
            
            URLImage(self.imageURL, placeholder: { _ in
                Text("Loading...")
                    .font(.customBody)
                
            }) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.red.opacity(0.2), lineWidth: 2))
            }
            .frame(maxWidth: 150.0, maxHeight: 150.0)
            .clipShape(Circle())
            .padding(15)

            HStack(alignment: .center, spacing: 10.0) {
                
                VStack(alignment: .center, spacing: 7) {
                    Text("President")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(self.team.president ?? "Unknown")")
                        .font(.customHeadline)
                        .multilineTextAlignment(.center)
                }
                .padding(10.0)
                
                Spacer()

                VStack(alignment: .center, spacing: 7) {
                    Text("Director")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(self.team.director ?? "Unknown")")
                        .font(.customHeadline)
                        .multilineTextAlignment(.center)
                }
                .padding(10.0)
            }
            .padding(20.0)
            .frame(maxWidth: .infinity)
            
            HStack(alignment: .center, spacing: 10.0) {
                
                VStack(alignment: .center, spacing: 7) {
                    Text("Technical Manager")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(self.team.technical_manager ?? "Unknown")")
                        .font(.customHeadline)
                        .multilineTextAlignment(.center)
                }
                .padding(10.0)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 7) {
                    Text("Engine")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(self.team.engine ?? "Unknown")")
                        .font(.customHeadline)
                        .multilineTextAlignment(.center)
                }
                .padding(10.0)
            }
            .padding(20.0)
            .frame(maxWidth: .infinity)

            Spacer()
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16.0)
        .padding(EdgeInsets(top: 15.0, leading: 15.0, bottom: 15.0, trailing: 15.0))
        .navigationTitle(team.name)
    }

}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: "Dietrich Mateschitz", director: "Christian Horner", technical_manager: "Adrian Newey", engine: "Honda V6 turbo hybride", tyres: "Pirelli"))
    }
}
