//
//  MemoryLeakCheckable.swift
//
//
//  Created by 김종원 on 2020/11/26.
//

import Foundation

protocol MemoryLeakCheckable: AnyObject {
    static func instantiateForLeakChecking() -> Self
    static func hasLeak(in block: ((Self) -> Void)?) -> Bool
}

extension MemoryLeakCheckable where Self: AnyObject {

    static func hasLeak(in block: ((Self) -> Void)? = nil) -> Bool {
        weak var leaked: AnyObject?
        autoreleasepool {
            var reference: Self? = instantiateForLeakChecking()
            leaked = reference
            _ = reference.map { block?($0) }
            reference = nil
        }
        return leaked != nil
    }
    
    static func hasLeak<T: AnyObject>(at keyPath: KeyPath<Self, T>, in block: ((Self) -> Void)? = nil) -> Bool {
        weak var leaked: AnyObject?
        autoreleasepool {
            var reference: Self? = instantiateForLeakChecking()
            _ = reference.map {
                block?($0)
                leaked = reference.map { $0[keyPath: keyPath] }
            }
            reference = nil
        }
        return leaked != nil
    }
    
    static func hasLeak(in block: ((Self) -> Void)? = nil, completion: @escaping (Bool) -> Void) {
        weak var leaked: AnyObject?
        autoreleasepool {
            var reference: Self? = instantiateForLeakChecking()
            leaked = reference
            _ = reference.map { block?($0) }
            reference = nil
        }
        DispatchQueue.main.async { [weak leaked] in
            completion(leaked != nil)
        }
    }
    
    static func hasLeak<T: AnyObject>(at keyPath: KeyPath<Self, T>, in block: ((Self) -> Void)? = nil, completion: @escaping (Bool) -> Void) {
        weak var leaked: AnyObject?
        autoreleasepool {
            var reference: Self? = instantiateForLeakChecking()
            _ = reference.map {
                block?($0)
                leaked = reference.map { $0[keyPath: keyPath] }
            }
            reference = nil
        }
        DispatchQueue.main.async { [weak leaked] in
            completion(leaked != nil)
        }
    }

}
