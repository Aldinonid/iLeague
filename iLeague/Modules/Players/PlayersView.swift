//
//  PlayerListView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import SwiftUI
import SwiftData

struct PlayersView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Player.level) private var players: [Player]
    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            ForEach(players) { player in
                NavigationLink(destination: AddPlayerView(isEdit: true)) {
                    VStack(alignment: .leading) {
                        Text(player.name)
                            .font(.headline)
                        
                        Text("Level: \(player.level)")
                    }
                }
            }
            .onDelete(perform: deletePlayer)
        }
        .sheet(isPresented: $isPresented, content: {
            AddPlayerView()
        })
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    isPresented.toggle()
                }
            }
        }
        .navigationTitle("Player List")
    }
    
    func deletePlayer(_ indexSet: IndexSet) {
        for index in indexSet {
            let player = players[index]
            modelContext.delete(player)
        }
    }
    
}

#Preview {
    PlayersView()
}
