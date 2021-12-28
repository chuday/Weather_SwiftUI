//
//  DateFormatter+Ext.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 13.12.2021.
//

import Foundation

extension DateFormatter {
    static func forecastFormat(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, HH:mm"
        return dateFormatter.string(from: date)
    }
}
