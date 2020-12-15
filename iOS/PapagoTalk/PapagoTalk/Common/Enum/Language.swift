//
//  Language.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation

enum Language: String, Codable, CaseIterable {
    case korean
    case english
    case french
    case japanese
    
    var localizedText: String {
        switch self {
        case .korean:
            return Strings.korean
        case .english:
            return Strings.english
        case .french:
            return "프랑스어"
        case .japanese:
            return Strings.japanese
        }
    }
    
    var code: String {
        switch self {
        case .korean:
            return "ko"
        case .english:
            return "en"
        case .french:
            return "fr"
        case .japanese:
            return "ja"
        }
    }
    
    var locale: Locale {
        switch self {
        case .korean:
            return Locale(identifier: "ko-KR")
        case .english:
            return Locale(identifier: "en-US")
        case .french:
            return Locale(identifier: "fr_KR")
        case .japanese:
            return Locale(identifier: "ja_KR")
        }
    }
    
    var index: Int {
        switch self {
        case .korean:
            return 0
        case .english:
            return 1
        case .french:
            return 2
        case .japanese:
            return 3
        }
    }
    
    static func codeToLanguage(of code: String) -> Language {
        switch code {
        case "ko":
            return .korean
        case "en":
            return .english
        case "fr":
            return .french
        case "ja":
            return .japanese
        default:
            return .english
        }
    }
}
