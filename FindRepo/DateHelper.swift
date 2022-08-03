//
//  DateHelper.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 09.07.2022.
//

import Foundation

final class DateHelper {

    static func convertDate(_ isoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate) ?? Date()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}

