//
//  Date+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/10.
//

import Foundation

extension Date {

    static func presentTimeStamp() -> String {
        var timeStamp = Date().timeIntervalSince1970
        timeStamp *= 1000
        return String(String(timeStamp).prefix(13))
    }
}
