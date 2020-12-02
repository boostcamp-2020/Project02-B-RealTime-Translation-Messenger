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
    
    var localizedText: String {
        switch self {
        case .korean:
            return Strings.korean
        case .english:
            return Strings.english
        }
    }
    
    var code: String {
        switch self {
        case .korean:
            return "ko"
        case .english:
            return "en"
        }
    }
    
    var index: Int {
        switch self {
        case .korean:
            return 0
        case .english:
            return 1
        }
    }
    
    static func codeToLanguage(of code: String) -> Language {
        switch code {
        case "ko":
            return .korean
        case "en":
            return .english
        default:
            return .english
        }
    }
}
