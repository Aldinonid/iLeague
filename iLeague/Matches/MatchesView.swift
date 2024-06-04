//
//  MatchesView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import SwiftUI
import SwiftData

struct MatchesView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query private var matches: [MatchModel]
    @State private var isPresented: Bool = false
    @State private var count: Int = 0
    
    var body: some View {
        List {
            ForEach(Array(matches.enumerated()), id: \.offset) { index, match in
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Match \(index + 1)")
                            Spacer()
                            Text(winTeam(match))
                                .font(.headline)
                        }
                        Divider()
                        matchView(match)
                    }
                }
            }
            .onDelete(perform: deleteMatch)
        }
        .listSectionSpacing(.compact)
        .sheet(isPresented: $isPresented, content: {
            AddMatchView()
        })
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    isPresented.toggle()
                }
            }
        }
        .navigationTitle("Match List")
    }
    
    func deleteMatch(_ indexSet: IndexSet) {
        for index in indexSet {
            let match = matches[index]
            modelContext.delete(match)
        }
    }
}

extension MatchesView {
    func matchView(_ match: MatchModel) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(match.player1.level)\(match.player2.level)")
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.capsule)
                Text("\(match.player1.name) - \(match.player2.name)")
                Spacer()
                if match.scoreA > match.scoreB {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                }
                Text("\(match.scoreA)")
            }
            Text("vs")
                .padding(.leading)
            HStack {
                Text("\(match.player3.level)\(match.player4.level)")
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.capsule)
                Text("\(match.player3.name) - \(match.player4.name)")
                Spacer()
                if match.scoreB > match.scoreA {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                }
                Text("\(match.scoreB)")
            }
        }
    }
}


#Preview {
    MatchesView()
}
