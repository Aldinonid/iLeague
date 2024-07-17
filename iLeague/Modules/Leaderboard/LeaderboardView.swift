//
//  LeaderboardView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-04.
//

import SwiftUI
import SwiftData

struct LeaderboardView: View {
    
    @Query private var listMatches: [MatchModel]
    @Query private var players: [Player]
    @State private var filteredListMatches: [String] = []
    @State private var filteredListPlayers: [Player] = []
    
    var body: some View {
        NavigationStack {
            List(Array(filteredListPlayers.enumerated()), id: \.offset) { index, player in
                HStack(spacing: 5) {
                    Text("\(index + 1).")
                    Text(player.name)
                    Spacer()
                    Text("\(player.level) pts")
                }
            }
            .navigationTitle("Leaderboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(filteredListMatches, id: \.self) { match in
                            Button(match) {
                                print(match)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .onAppear { fetchMatch() }
        }
    }
}

extension LeaderboardView {
    
    func fetchPlayers() {
        filteredListPlayers = players
    }
    
    func fetchMatch() {
        filteredListMatches = listMatches.uniques(by: \.date).map { $0.date }
        fetchPlayers()
    }
    
}

#Preview {
    LeaderboardView()
}
