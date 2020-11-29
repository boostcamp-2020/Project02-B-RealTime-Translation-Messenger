//
//  Language.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation

enum Language: CaseIterable {
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
}
