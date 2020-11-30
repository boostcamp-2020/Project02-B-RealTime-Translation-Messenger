//
//  DateFormatter+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatter = DateFormatter()
    
    // TODO: Localization
    static func chatDateFormat(of date: Date) -> String {
        dateFormatter.dateFormat = "yyyy년 M월 d일 EEEE"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
    
    // TODO: Localization
    static func chatTimeFormat(of date: Date) -> String {
        dateFormatter.dateFormat = "a H:mm"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: date)
    }
}
