//
//  DateFormatter+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatter = DateFormatter()
    
    static func format(of date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd-ss"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
}
