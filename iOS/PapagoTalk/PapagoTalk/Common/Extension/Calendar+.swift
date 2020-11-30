//
//  Calendar+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import Foundation

extension Calendar {
    
    static let calendar = Calendar(identifier: Calendar.autoupdatingCurrent.identifier)

    static func isSameDate(of firstDate: Date, with secondDate: Date) -> Bool {
        return calendar.isDate(firstDate, inSameDayAs: secondDate)
    }
}
