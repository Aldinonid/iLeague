//
//  ContentView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            NavigationStack {
                MatchesView()
            }
            .tabItem {
                Image(systemName: "apps.ipad.landscape")
                Text("Match")
            }
            
            NavigationStack {
                ScoreboardView()
            }
            .tabItem {
                Image(systemName: "figure.badminton")
                Text("Scoreboard")
            }
            
            NavigationStack {
                PlayersView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Players")
            }
            
            NavigationStack {
                LeaderboardView()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Ranking")
            }
        }
    }
}

#Preview {
    ContentView()
}
