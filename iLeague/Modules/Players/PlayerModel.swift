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
    let name: String
    let level: String
    let shoes: String?
    let racket: String?
    let photo: String?
    
    init(name: String, level: String) {
        self.name = name
        self.level = level
    }
}
