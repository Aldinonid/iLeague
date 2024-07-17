//
//  PlayerModel.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import Foundation
import SwiftData

@Model
final class Player {
    var name: String
    var level: String
    var shoes: String?
    var racket: String?
    var photo: String?
    
    init(name: String, level: String) {
        self.name = name
        self.level = level
    }
}
