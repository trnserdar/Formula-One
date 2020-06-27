//
//  DriverPersonalView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI
import URLImage

struct DriverPersonalView: View {
    
    var driver: DriverModel
    
    var imageURL: URL {
        
        guard driver.image != nil,
            let url = URL(string: driver.image!) else {
            return URL(string: "https://media.api-sports.io/formula-1")!
        }
    
        return url
    }
    
    var birthdate: String {
        
        guard let birthdate = driver.birthdate else {
            return "Unknown"
        }
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputDateFormatter.date(from: birthdate) else {
            return "Unknown"
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMM d, yyyy"
        
        return outputDateFormatter.string(from: date)
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

            HStack(alignment: .top, spacing: 20.0) {
                
                VStack(alignment: .center, spacing: 7) {
                    Text("Nationality")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(self.driver.nationality ?? "Unknown")")
                        .font(.customHeadline)
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .center, spacing: 7) {
                    Text("Birthdate")
                        .font(.customHeadline)
                        .foregroundColor(Color.officialColor)
                    Text("\(self.birthdate)")
                        .font(.customHeadline)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(10.0)
            .frame(maxWidth: .infinity)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16.0)
        .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
    }
}

struct DriverPersonalView_Previews: PreviewProvider {
    static var previews: some View {
        DriverPersonalView(driver: DriverModel(id: 25, name: "Max Verstappen", image: "https://media.api-sports.io/formula-1/drivers/25.png", nationality: "Dutch", birthdate: "1997-09-30", teams: [DriverTeamModel(season: 2019, team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil)),
                                                                                                                                                                                                     
                                                                                                                                                                                                     DriverTeamModel(season: 2018, team: TeamModel(id: 1, name: "Red Bull Racing", logo: "https://media.api-sports.io/formula-1/teams/1.png", president: nil, director: nil, technical_manager: nil, engine: nil, tyres: nil))]))
    }
}
