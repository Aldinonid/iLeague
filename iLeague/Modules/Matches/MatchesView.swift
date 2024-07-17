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
    @State private var listDates: [String] = []
    @State private var filteredMatches: [MatchModel] = []
    @State private var isPresented: Bool = false
    @State private var count: Int = 0
    
    var body: some View {
        List {
            ForEach(Array(filteredMatches.enumerated()), id: \.offset) { index, match in
                Section {
                    NavigationLink(destination: AddMatchView(isEdit: true, match: match)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Match \(index + 1)")
                                Spacer()
                                Text(match.winTeam())
                                    .font(.headline)
                            }
                            Divider()
                            matchView(match)
                        }
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
                ShareLink(item:generateCSV(filteredMatches)) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Menu {
                        ForEach(listDates, id: \.self) { date in
                            Button(date) {
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
        .navigationTitle(filteredMatches.first?.date ?? "Match List")
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
    
    func selectDateMatch(date: String) {
        print("-s matches: \(matches.uniques(by: \.date).map{$0.date})")
        print("-s date: \(date.convertToDate().convertDateWithFormat(format: DateFormat.fullDate.rawValue))")
        filteredMatches = matches.uniques(by: \.date).filter {
            $0.date == date.convertToDate().convertDateWithFormat(format: DateFormat.fullDate.rawValue)
        }
    }
    
    func fetchMatches() {
        listDates = matches.map { $0.date.convertToDateStyle() }.unique()
        filteredMatches = matches.filter { $0.date == matches.first?.date }
    }
    
    func generateCSV(_ data: [MatchModel]) -> URL {
        var fileURL: URL!
        let heading = "player1,player2,player3,player4,score\n"
        let rows = data.map { $0.winLoseTeam() }
        let stringData = heading + rows.joined(separator: "\n")
        
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            fileURL = path.appendingPathComponent("Match_Data.csv")
            try stringData.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error generate file")
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
