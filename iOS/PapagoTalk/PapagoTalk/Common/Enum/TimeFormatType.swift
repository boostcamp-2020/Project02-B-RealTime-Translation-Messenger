//
//  TimeFormatType.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/14.
//

import Foundation

enum TimeFormatType {
    case time
    case yesterday
    case date
    case fullDate
    
    var format: String {
        switch self {
        case .time:
            return "a h:mm"
        case .yesterday:
            return "yesterday".localized
        case .date:
            return "MMMM dd".localized
        case .fullDate:
            return "M. d. yyyy.".localized
        }
    }
}
