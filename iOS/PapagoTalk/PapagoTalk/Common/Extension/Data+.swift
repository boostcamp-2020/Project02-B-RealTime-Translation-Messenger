//
//  Data+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

extension Data {
 
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: self)
    }
}
