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
                Image(systemName: "figure.badminton")
                Text("Match")
            }
            
            NavigationStack {
                LeaderboardView()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Ranking")
            }
            
            NavigationStack {
                PlayersView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Players")
            }
        }
    }
}

#Preview {
    ContentView()
}
