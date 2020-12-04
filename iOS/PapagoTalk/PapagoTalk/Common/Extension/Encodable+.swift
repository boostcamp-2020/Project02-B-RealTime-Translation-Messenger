//
//  Encodable+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

extension Encodable {
    
    func encoded() -> Data {
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(self) else {
            return Data()
        }
        return encodedData
    }
}
