//
//  HTTPMethod.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

enum HTTPMethod: CustomStringConvertible {
    case get
    case post
    case patch
    case delete
    
    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}
