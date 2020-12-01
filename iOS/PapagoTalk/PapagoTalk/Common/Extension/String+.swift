//
//  String+.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/29.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: "")
    }
    
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self.toDouble()))
    }
    
    private func toDouble() -> Double {
        guard let doubleValue = Double(self.prefix(10)) else {
            return .zero
        }
        return doubleValue
    }
}
