//
//  TeamItemView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 28.06.2020.
//

import SwiftUI
import URLImage

struct TeamItemView: View {
    
    var team: TeamModel
    
    var imageURL: URL {
        
        guard team.logo != nil,
            let url = URL(string: team.logo!) else {
            return URL(string: "https://media.api-sports.io/formula-1")!
        }
    
        return url
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10.0) {
            
            Spacer(minLength: 10.0)
            
            Text("\(team.name)")
                .font(.customHeadline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            Text("\(team.director ?? "Unknown")")
                .font(.customSubheadline)
                .foregroundColor(.officialColor)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Spacer(minLength: 10.0)
        }
        .padding(EdgeInsets(top: 5.0, leading: 10.0, bottom: 5.0, trailing: 10.0))
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16.0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TeamItemView_Previews: PreviewProvider {
    static var previews: some View {
        TeamItemView(team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: "Dietrich Mateschitz", director: "Christian Horner", technical_manager: "Adrian Newey", engine: "Honda V6 turbo hybride", tyres: "Pirelli"))
    }
}
