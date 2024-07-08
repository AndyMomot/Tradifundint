//
//  String+Additions.swift
//  Tradifundint
//
//  Created by Andrii Momot on 08.07.2024.
//

import Foundation

extension String {
    func toDate(format: Date.Format) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}
