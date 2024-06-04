//
//  Date+Ext.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-04.
//

import Foundation

extension Date {
    func convertDateWithFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
