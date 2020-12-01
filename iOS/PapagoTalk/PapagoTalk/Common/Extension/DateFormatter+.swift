//
//  DateFormatter+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatter = DateFormatter()
    
    static func chatDateFormat(of date: Date) -> String {
        dateFormatter.dateFormat = "yyyy MMMM dd EEEE"
        // dateFormatter.dateStyle = .medium
        // dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Locale.autoupdatingCurrent.identifier)
        return dateFormatter.string(from: date)
    }
    
    static func chatTimeFormat(of date: Date) -> String {
        dateFormatter.dateFormat = "a H:mm"
        dateFormatter.locale = Locale(identifier: Locale.autoupdatingCurrent.identifier)
        return dateFormatter.string(from: date)
    }
}
