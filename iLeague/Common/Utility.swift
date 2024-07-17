//
//  Utility.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-04.
//

import Foundation

let winRank: [String: Int] = [
    "A": 1,
    "B": 2,
    "C": 3,
    "D": 4
]

let loseRank: [String: Int] = [
    "A": 4,
    "B": 3,
    "C": 2,
    "D": 1
]

enum PlayerSelected {
    case player1, player2, player3, player4
}

//func winScoreCalculation(_ player: PlayerSelected) -> Int {
//    guard let point1 = winRank[player1.level],
//          let point2 = winRank[player2.level],
//          let point3 = winRank[player3.level],
//          let point4 = winRank[player4.level]
//    else { return 0 }
//    var total: Int = 0
//    let totalLevelMatchPoint = Double(point1 + point2 + point3 + point4)
//    var totalTeamOpponentWinPoint: Double?
//    var totalTeamSelfWinPoint: Double?
//    switch player {
//        case .player1:
//            totalTeamOpponentWinPoint = Double(point1 + point2) / Double(point3 + point4)
//            totalTeamSelfWinPoint = Double(point1) / totalLevelMatchPoint
//            total = Int(ceil((totalTeamSelfWinPoint ?? 0.0) * (totalTeamOpponentWinPoint ?? 0.0) * 100))
//        case .player2:
//            totalTeamOpponentWinPoint = Double(point1 + point2) / Double(point3 + point4)
//            totalTeamSelfWinPoint = Double(point2) / totalLevelMatchPoint
//            total = Int(ceil((totalTeamSelfWinPoint ?? 0.0) * (totalTeamOpponentWinPoint ?? 0.0) * 100))
//        case .player3:
//            totalTeamOpponentWinPoint = Double(point3 + point4) / Double(point1 + point2)
//            totalTeamSelfWinPoint = Double(point3) / totalLevelMatchPoint
//            total = Int(ceil((totalTeamSelfWinPoint ?? 0.0) * (totalTeamOpponentWinPoint ?? 0.0) * 100))
//        case .player4:
//            totalTeamOpponentWinPoint = Double(point3 + point4) / Double(point1 + point2)
//            totalTeamSelfWinPoint = Double(point4) / totalLevelMatchPoint
//            total = Int(ceil((totalTeamSelfWinPoint ?? 0.0) * (totalTeamOpponentWinPoint ?? 0.0) * 100))
//    }
//    return total
//}

//func loseScoreCalculation(_ player: PlayerSelected) -> Int {
//    guard let point1 = loseRank[player1.level],
//          let point2 = loseRank[player2.level],
//          let point3 = loseRank[player3.level],
//          let point4 = loseRank[player4.level]
//    else { return 0 }
//    var total: Int = 0
//    let totalLevelMatchPoint = Double(point1 + point2 + point3 + point4)
//    var totalTeamOpponentLosePoint: Double?
//    var totalTeamSelfLosePoint: Double?
//    switch player {
//        case .player1:
//            totalTeamOpponentLosePoint = Double(point1 + point2) / Double(point3 + point4)
//            totalTeamSelfLosePoint = Double(point1) / totalLevelMatchPoint
//            total = Int(floor((totalTeamSelfLosePoint ?? 0.0) * (totalTeamOpponentLosePoint ?? 0.0) * -100))
//        case .player2:
//            totalTeamOpponentLosePoint = Double(point1 + point2) / Double(point3 + point4)
//            totalTeamSelfLosePoint = Double(point2) / totalLevelMatchPoint
//            total = Int(floor((totalTeamSelfLosePoint ?? 0.0) * (totalTeamOpponentLosePoint ?? 0.0) * -100))
//        case .player3:
//            totalTeamOpponentLosePoint = Double(point3 + point4) / Double(point1 + point2)
//            totalTeamSelfLosePoint = Double(point3) / totalLevelMatchPoint
//            total = Int(floor((totalTeamSelfLosePoint ?? 0.0) * (totalTeamOpponentLosePoint ?? 0.0) * -100))
//        case .player4:
//            totalTeamOpponentLosePoint = Double(point3 + point4) / Double(point1 + point2)
//            totalTeamSelfLosePoint = Double(point4) / totalLevelMatchPoint
//            total = Int(floor((totalTeamSelfLosePoint ?? 0.0) * (totalTeamOpponentLosePoint ?? 0.0) * -100))
//    }
//    return total
//}

//func scoreCalculation(_ match: MatchModel) {
//    if match.scoreA > match.scoreB {
//        pointPlayer1 = winScoreCalculation(.player1)
//        pointPlayer2 = winScoreCalculation(.player2)
//        pointPlayer3 = loseScoreCalculation(.player3)
//        pointPlayer4 = loseScoreCalculation(.player4)
//    } else {
//        pointPlayer1 = loseScoreCalculation(.player1)
//        pointPlayer2 = loseScoreCalculation(.player2)
//        pointPlayer3 = winScoreCalculation(.player3)
//        pointPlayer4 = winScoreCalculation(.player4)
//    }
//}
