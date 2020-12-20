//
//  UserDefault.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    
    private let key: String
    private let defaultValue: T
    
    init(type: UserDefaultType, default: T) {
        key = type.key
        defaultValue = `default`
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data,
                  let value: T = try? data.decoded()
            else {
                return defaultValue
            }
            return value
        }
        set {
            UserDefaults.standard.set(newValue.encoded(), forKey: key)
        }
    }
}
