//
//  AddMatchView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import SwiftUI
import SwiftData

struct AddMatchView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var players: [Player]
    @State private var player1: Player?
    @State private var player2: Player?
    @State private var player3: Player?
    @State private var player4: Player?
    @State private var scoreA = ""
    @State private var scoreB = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                DatePicker(
                    "Match Date", 
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                
                HStack {
                    Selection(player1, placeholder: "Player 1") { player in
                        player1 = player
                    }
                    
                    Spacer()
                    
                    Selection(player2, placeholder: "Player 2") { player in
                        player2 = player
                    }
                }
                .frame(maxHeight: 50)
                
                TextField("Score A", text: $scoreA)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .keyboardType(.numberPad)
                
                Text("vs")
                
                HStack {
                    Selection(player3, placeholder: "Player 3") { player in
                        player3 = player
                    }
                    
                    Spacer()
                    
                    Selection(player4, placeholder: "Player 4") { player in
                        player4 = player
                    }
                }
                .frame(maxHeight: 50)
                
                TextField("Score B", text: $scoreB)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .keyboardType(.numberPad)
                
                Spacer()
            }
            .navigationTitle("Add new match 🏸")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveMatch()
                    } label: {
                        Text("Done")
                    }
                    
                    .disabled(disableForm)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddMatchView()
}


extension AddMatchView {
    
    var disableForm: Bool {
        scoreA.isEmpty ||
        scoreB.isEmpty ||
        player1 == nil ||
        player2 == nil ||
        player3 == nil ||
        player4 == nil
    }
    
    func saveMatch() {
        guard let player1,
              let player2,
              let player3,
              let player4  else { return }
        let match = MatchModel(scoreA: Int(scoreA) ?? 0,
                               scoreB: Int(scoreB) ?? 0,
                               player1: player1,
                               player2: player2,
                               player3: player3,
                               player4: player4,
                               date: date)
        modelContext.insert(match)
        dismiss()
    }
    
    func Selection(_ playerField: Player?, placeholder: String = "", onSelect: @escaping (Player) -> Void) -> some View {
        Menu {
            ForEach(players) { player in
                Button(player.name) {
                    onSelect(player)
                }
            }
        } label: {
            HStack {
                Text(playerField?.name ?? placeholder)
                    .foregroundStyle(Color.black)
                Spacer()
                Divider()
                Image(systemName: "chevron.right")
                    .rotationEffect(Angle(degrees: 90))
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    var firstView: some View {
        List {
            Section {
                HStack {
                    Text("Player 1")
                    Spacer()
                    Menu {
                        ForEach(players) { player in
                            Button(player.name) {
                                player1 = player
                            }
                        }
                    } label: {
                        Text(player1?.name ?? "Select Player")
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                HStack {
                    Text("Player 2")
                    Spacer()
                    Menu {
                        ForEach(players) { player in
                            Button(player.name) {
                                player2 = player
                            }
                        }
                    } label: {
                        Text(player2?.name ?? "Select Player")
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                TextField("Score A", text: $scoreA)
                    .keyboardType(.numberPad)
            }
            
            Section("vs") {
                HStack {
                    Text("Player 3")
                    Spacer()
                    Menu {
                        ForEach(players) { player in
                            Button(player.name) {
                                player3 = player
                            }
                        }
                    } label: {
                        Text(player3?.name ?? "Select Player")
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                HStack {
                    Text("Player 4")
                    Spacer()
                    Menu {
                        ForEach(players) { player in
                            Button(player.name) {
                                player4 = player
                            }
                        }
                    } label: {
                        Text(player4?.name ?? "Select Player")
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                TextField("Score B", text: $scoreB)
                    .keyboardType(.numberPad)
            }
            
        }
        .listStyle(.plain)
    }
    
}
