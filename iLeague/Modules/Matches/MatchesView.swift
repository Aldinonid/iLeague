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
    @State private var listDates: [Date] = []
    @State private var filteredMatches: [MatchModel] = []
    @State private var isPresented: Bool = false
    @State private var count: Int = 0
    
    var body: some View {
        List {
            ForEach(Array(filteredMatches.enumerated()), id: \.offset) { index, match in
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
            ToolbarItem(placement: .topBarLeading) {
                ShareLink(item: generateCSV(filteredMatches))
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Menu {
                        ForEach(listDates, id: \.self) { date in
                            Button(date.convertDateWithFormat()) {
                                selectDateMatch(date: date)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    
                    Button("Add") {
                        isPresented.toggle()
                    }
                }
            }
        }
        .navigationTitle(filteredMatches.first?.date.convertDateWithFormat() ?? "Match List")
        .onAppear { fetchMatches() }
    }
    
    func deleteMatch(_ indexSet: IndexSet) {
        for index in indexSet {
            let match = matches[index]
            modelContext.delete(match)
        }
    }
}

extension MatchesView {
    
    func selectDateMatch(date: Date) {
        filteredMatches = matches.filter { $0.date == date }
    }
    
    func fetchMatches() {
        listDates = matches.uniques(by: \.date).map { $0.date }
        filteredMatches = matches.filter { $0.date == matches.first?.date }
    }
    
    func generateCSV(_ data: [MatchModel]) -> URL {
        let todayDate = Date().convertDateWithFormat()
        var fileURL: URL!
        let heading = "levelMatch,player1,player2,player3,player4,score\n"
        let rows = data.map {
            "\($0.player1.level)\($0.player2.level) - \($0.player3.level)\($0.player4.level)," +
            "\($0.player1.name),\($0.player2.name),\($0.player3.name),\($0.player4.name)," +
            "\($0.scoreA) - \($0.scoreB)"
        }
        let stringData = heading + rows.joined(separator: "\n")
        
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            fileURL = path.appending(path: "Match Data - \(todayDate).csv", directoryHint: .checkFileSystem)
            try stringData.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error generate csv file")
        }
        return fileURL
    }
    
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
