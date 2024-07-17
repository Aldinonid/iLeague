//
//  MatchModel.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import Foundation
import SwiftData

@Model
final class MatchModel {
    var scoreA: Int
    var scoreB: Int
    var date: String
    var pointPlayer1: Int?
    var pointPlayer2: Int?
    var pointPlayer3: Int?
    var pointPlayer4: Int?
    var winPlayer: String? = ""
    @Relationship() var player1: Player
    @Relationship() var player2: Player
    @Relationship() var player3: Player
    @Relationship() var player4: Player
    
    init(scoreA: Int, scoreB: Int, player1: Player, player2: Player, player3: Player, player4: Player, date: String) {
        self.scoreA = scoreA
        self.scoreB = scoreB
        self.player1 = player1
        self.player2 = player2
        self.player3 = player3
        self.player4 = player4
        self.date = date
    }
}

extension MatchModel {
    func winTeam() -> String {
        scoreA > scoreB ? "\(player1.name) - \(player2.name)" : "\(player3.name) - \(player4.name)"
    }
    
    func winLoseTeam() -> String {
        scoreA > scoreB ?
        "\(player1.name),\(player2.name),\(player3.name),\(player4.name), \(scoreA) - \(scoreB)" :
        "\(player3.name),\(player4.name),\(player1.name),\(player2.name), \(scoreB) - \(scoreA)"
    }
}
