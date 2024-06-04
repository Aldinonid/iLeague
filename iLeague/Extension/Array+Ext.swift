//
//  Array+Ext.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-04.
//

import Foundation

extension Array {
    func uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return reduce([]) { result, element in
            let alreadyExist = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }))
            return alreadyExist ? result : result + [element]
        }
    }
}
