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
    case japanese
    case chinese
    
    var localizedText: String {
        switch self {
        case .korean:
            return Strings.korean
        case .english:
            return Strings.english
        case .japanese:
            return Strings.japanese
        case .chinese:
            return Strings.chinese
        }
    }
    
    var code: String {
        switch self {
        case .korean:
            return "ko"
        case .english:
            return "en"
        case .japanese:
            return "ja"
        case .chinese:
            return "zh-cn"
        }
    }
    
    var locale: Locale {
        switch self {
        case .korean:
            return Locale(identifier: "ko-KR")
        case .english:
            return Locale(identifier: "en-US")
        case .japanese:
            return Locale(identifier: "ja_KR")
        case .chinese:
            return Locale(identifier: "zh_Hans")
        }
    }
    
    var index: Int {
        switch self {
        case .korean:
            return 0
        case .english:
            return 1
        case .japanese:
            return 2
        case .chinese:
            return 3
        }
    }
    
    static func codeToLanguage(of code: String) -> Language {
        switch code {
        case "ko":
            return .korean
        case "en":
            return .english
        case "ja":
            return .japanese
        case "zh-cn":
            return .chinese
        default:
            return .english
        }
    }
}
