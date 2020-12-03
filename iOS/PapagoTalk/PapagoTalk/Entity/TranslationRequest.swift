//
//  TranslationRequest.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

struct TranslationRequest: Codable {
    let source: String
    let target: String
    let text: String
}
