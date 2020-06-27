//
//  MainView.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        
        TabView {
            
            RankingsView()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Rankings")
                    .foregroundColor(Color.gray.opacity(0.3))
                }
            
            ResultsView()
                .tabItem {
                    Image(systemName: "list.bullet.indent")
                    Text("Results")
                    .foregroundColor(Color.gray.opacity(0.3))
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                    .foregroundColor(Color.gray.opacity(0.3))
                }
            
            CircuitsView()
                .tabItem {
                    Image(systemName: "circle")
                    Text("Circuits")
                    .foregroundColor(Color.gray.opacity(0.3))
                }

        }
        .accentColor(Color.officialColor)
        .onAppear(perform: {

            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.officialColor, .font: UIFont(name: "Formula1-Display-Bold", size: 30)!]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.officialColor, .font: UIFont(name: "Formula1-Display-Bold", size: 20)!]

            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Formula1-Display-Bold", size: 10)!], for: .normal)
            
            UITableView.appearance().separatorStyle = .none

            UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "Formula1-Display-Regular", size: 13)!, .foregroundColor: UIColor.officialColor.withAlphaComponent(1.0)], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "Formula1-Display-Regular", size: 13)!, .foregroundColor: UIColor.gray.withAlphaComponent(0.3)], for: .normal)
        })
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
