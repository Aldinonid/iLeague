//
//  String_Ext.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-07-14.
//

import Foundation

extension String {
    func convertToDateStyle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.fullDate.rawValue
        let date = dateFormatter.date(from: self) ?? Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .medium
        return dateFormatter2.string(from: date)
    }
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.fullDate.rawValue
        return dateFormatter.date(from: self) ?? Date()
    }
}
