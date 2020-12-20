//
//  IOCContainer.swift
//
//
//  Created by 김종원 on 2020/12/03.
//

import Foundation

typealias Build = (Resolver) -> Any

private protocol Builder {
    func build<T>(_ resolver: Resolver) -> T
    init(_ build: @escaping Build)
}

private final class AnyBuilder: Builder {
    let build: Build
    
    required init(_ build: @escaping Build) {
        self.build = build
    }
    
    func build<T>(_ resolver: Resolver) -> T {
        guard let resolved = build(resolver) as? T else {
            fatalError()
        }
        return resolved
    }
}

private typealias Container = [String: Builder]

/// Simple IoC Container - Test용
final class Resolver {
    static let shared = Resolver(container: [:])
    
    private var container: Container = [:]
    
    private init(container: Container) {
        self.container = container
    }

    @discardableResult
    func regist<T>(_ build: @escaping (Resolver) -> T) -> Resolver {
        container[String(describing: T.self)] = AnyBuilder(build)
        return self
    }
    
    func resolve<T>() -> T {
        guard let builder = container[String(describing: T.self)] else {
            fatalError()
        }
        return builder.build(self)
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        resolve()
    }
}

extension Resolver {
    static func empty() -> Resolver {
        Resolver(container: [:])
    }
    
    static func regist<T>(_ build: @escaping (Resolver) -> T) -> Resolver {
        Resolver(container: [String(describing: T.self): AnyBuilder(build)])
    }
    
    static func + (lhs: Resolver, rhs: Resolver) -> Resolver {
        var merged: Container = lhs.container
        for (name, builder) in rhs.container {
            merged[name] = builder
        }
        return Resolver(container: merged)
    }
}

protocol Resolvable {}

extension Resolvable {
    static func resolve(from resolver: Resolver = .shared) -> Self {
        resolver.resolve()
    }
}

extension MemoryLeakCheckable where Self: Resolvable {
    static func instantiateForLeakChecking() -> Self {
        Self.resolve()
    }
}
