//
//  Item.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
