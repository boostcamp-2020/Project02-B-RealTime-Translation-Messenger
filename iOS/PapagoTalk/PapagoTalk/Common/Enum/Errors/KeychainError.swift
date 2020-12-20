//
//  KeychainError.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/07.
//

import Foundation

enum KeychainError: Error {
    case updateFailed(key: String, description: String)
    case insertFailed(key: String, description: String)
    case removeFailed(key: String, description: String)
}
