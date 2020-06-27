//
//  FormulaOneApp.swift
//  FormulaOneWatch Extension
//
//  Created by Serdar Turan on 27.06.2020.
//

import SwiftUI

@main
struct FormulaOneApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
