//
//  AnswersAiApp.swift
//  AnswersAi
//
//  Created by Nishant on 5/21/25.
//

import SwiftUI

@main
struct AnswersAiApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                TodayView()
                    .tabItem {
                        Image(systemName: "doc.text.image")
                            .symbolVariant(.fill)
                        Text("Today")
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "paperplane")
                        Text("Games")
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "square.stack.3d.up")
                        Text("Apps")
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Arcade")
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
                 .preferredColorScheme(.dark)
        }
    }
}
