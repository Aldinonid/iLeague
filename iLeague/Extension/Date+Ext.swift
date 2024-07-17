//
//  Date+Ext.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-04.
//

import Foundation

extension Date {
    func convertDateWithFormat(format: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func convertDateWithStyle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}

enum DateFormat: String {
    case fullDate = "dd/MM/yy"
}
