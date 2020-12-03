//
//  TranslationResponse.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

struct TranslationResponse: Codable {
    
    struct Message: Codable {
        let result: Result
    }
    
    struct Result: Codable {
        let srcLangType: String?
        let tarLangType: String?
        let translatedText: String
    }

    let message: Message
    
}
