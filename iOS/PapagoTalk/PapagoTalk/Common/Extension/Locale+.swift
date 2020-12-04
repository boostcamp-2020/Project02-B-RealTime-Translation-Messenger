//
//  Locale+.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/25.
//

import Foundation

extension Locale {
    
    static var preferredLanguageCode: String {
        let defaultLanguage = "en"
        let preferredLanguage = preferredLanguages.first ?? defaultLanguage
        return Locale(identifier: preferredLanguage).languageCode ?? defaultLanguage
    }
    
    static var currentLanguage: Language {
        switch preferredLanguageCode {
        case "ko":
            return .korean
        case "en":
            return .english
        default:
            return .english
        }
    }
}
