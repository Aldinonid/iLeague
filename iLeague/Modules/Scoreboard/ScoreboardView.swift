//
//  ScoreboardView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-07-05.
//

import SwiftUI
import SwiftData

struct ScoreboardView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query private var players: [Player]
    @State private var player1: Player?
    @State private var player2: Player?
    @State private var player3: Player?
    @State private var player4: Player?
    @State private var scoreA = 0
    @State private var scoreB = 0
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 2) {
                HStack(spacing: 4) {
                    Selection(player1, placeholder: "Player") { player in
                        player1 = player
                    }
                    Selection(player2, placeholder: "Player") { player in
                        player2 = player
                    }
                    
                }
                .padding(4)
                .frame(maxHeight: 50)
                
                Text("vs")
                
                HStack(spacing: 4) {
                    Selection(player3, placeholder: "Player") { player in
                        player3 = player
                    }
                    Selection(player4, placeholder: "Player") { player in
                        player4 = player
                    }
                }
                .padding(4)
                .frame(maxHeight: 50)
            }
            
            Spacer()
                .frame(height: 20)
            
            scoreboard
            
            Spacer()
            
            Button(action: {
                saveMatch()
                scoreA = 0
                scoreB = 0
                player1 = nil
                player2 = nil
                player3 = nil
                player4 = nil
            }, label: {
                Text("Finish")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 80)
//                    .background(Color.gray.opacity(0.1))
            })
            
        }
    }
}

extension ScoreboardView {
    
    func saveMatch() {
        guard let player1,
              let player2,
              let player3,
              let player4  else { return }
        let match = MatchModel(scoreA: scoreA,
                               scoreB: scoreB,
                               player1: player1,
                               player2: player2,
                               player3: player3,
                               player4: player4,
                               date: Date().convertDateWithStyle())
        modelContext.insert(match)
    }
    
    func Selection(_ playerField: Player?, placeholder: String = "", onSelect: @escaping (Player) -> Void) -> some View {
        Menu {
            ForEach(players.sorted(by: \.name)) { player in
                Button(player.name) {
                    onSelect(player)
                }
            }
        } label: {
            Text(playerField?.name ?? placeholder)
                .foregroundStyle(Color.black)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    var scoreboard: some View {
        HStack(spacing: 4) {
            VStack(spacing: 4) {
                Button(action: {
                    scoreA += 1
                }, label: {
                    Text(String(scoreA))
                        .font(.system(size: 150))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color.gray.opacity(0.1))
                })
                .buttonStyle(NoTapAnimationStyle())
                
                Button(action: {
                    scoreA -= 1
                }, label: {
                    Image(systemName: "chevron.right")
                        .rotationEffect(Angle(degrees: 90))
                })
                .padding()
            }
            
            VStack(spacing: 4) {
                Button(action: {
                    scoreB += 1
                }, label: {
                    Text(String(scoreB))
                        .font(.system(size: 150))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color.gray.opacity(0.1))
                })
                .buttonStyle(NoTapAnimationStyle())
                
                Button(action: {
                    scoreB -= 1
                }, label: {
                    Image(systemName: "chevron.right")
                        .rotationEffect(Angle(degrees: 90))
                })
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
