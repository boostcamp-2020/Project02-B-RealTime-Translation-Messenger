//
//  TranslationResponse.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: TranslationResult
}

struct TranslationResult: Codable {
    let srcLangType: String?
    let tarLangType: String?
    let translatedText: String
}
