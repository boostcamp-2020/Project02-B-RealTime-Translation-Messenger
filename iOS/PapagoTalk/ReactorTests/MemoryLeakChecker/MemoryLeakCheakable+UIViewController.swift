//
//  MemoryLeakCheakable+UIViewController.swift
//  
//
//  Created by 김종원 on 2020/12/03.
//

import UIKit

extension MemoryLeakCheckable where Self: UIViewController {
    
    static func hasLeakInLifeCycle() -> Bool {
        Self.hasLeak(in: {
            $0.loadViewIfNeeded()
            $0.viewWillAppear(true)
            $0.viewDidAppear(true)
            $0.viewWillDisappear(true)
            $0.viewDidDisappear(true)
        })
    }
    
    static func hasLeakInLifeCycle(completion: @escaping (Bool) -> Void) {
        Self.hasLeak(in: {
            $0.loadViewIfNeeded()
            $0.viewWillAppear(true)
            $0.viewDidAppear(true)
            $0.viewWillDisappear(true)
            $0.viewDidDisappear(true)
        }, completion: completion)
    }
    
    static func hasLeakInLifeCycle<T: AnyObject>(at keyPath: KeyPath<Self, T>) -> Bool {
        Self.hasLeak(at: keyPath, in: {
            $0.loadViewIfNeeded()
            $0.viewWillAppear(true)
            $0.viewDidAppear(true)
            $0.viewWillDisappear(true)
            $0.viewDidDisappear(true)
        })
    }
    
    static func hasLeakInLifeCycle<T: AnyObject>(at keyPath: KeyPath<Self, T>, completion: @escaping (Bool) -> Void) {
        Self.hasLeak(at: keyPath, in: {
            $0.loadViewIfNeeded()
            $0.viewWillAppear(true)
            $0.viewDidAppear(true)
            $0.viewWillDisappear(true)
            $0.viewDidDisappear(true)
        }, completion: completion)
    }
}
