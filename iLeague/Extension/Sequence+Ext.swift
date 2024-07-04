//
//  Sequence+Ext.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-07-01.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
