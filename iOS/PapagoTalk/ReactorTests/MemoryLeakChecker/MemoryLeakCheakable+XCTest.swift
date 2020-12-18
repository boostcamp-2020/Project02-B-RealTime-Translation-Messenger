//
//  MemoryLeakCheakable+XCTest.swift
//  
//
//  Created by 김종원 on 2020/12/03.
//

import XCTest

extension XCTestCase {
    
    func XCTAssertLeak<T: MemoryLeakCheckable>(
        _ type: T.Type,
        in block: ((T) -> Void)? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        var isLeaked = true
        let expect = expectation(description: "leak")
        
        type.hasLeak(in: block, completion: {
            isLeaked = $0
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertFalse(isLeaked, file: file, line: line)
    }
    
    func XCTAssertLeak<T: MemoryLeakCheckable, U: AnyObject>(
        _ type: T.Type,
        at keyPath: KeyPath<T, U>,
        in block: ((T) -> Void)? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        var isLeaked = true
        let expect = expectation(description: "leak")
        
        type.hasLeak(at: keyPath, in: block, completion: {
            isLeaked = $0
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertFalse(isLeaked, file: file, line: line)
    }
    
    func XCTAssertLeak<T: MemoryLeakCheckable & UIViewController>(
        viewController: T.Type,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        var isLeaked = true
        let expect = expectation(description: "leak")
        
        viewController.hasLeakInLifeCycle {
            isLeaked = $0
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertFalse(isLeaked, file: file, line: line)
    }
    
    func XCTAssertLeak<T: MemoryLeakCheckable & UIViewController, U: AnyObject>(
        viewController: T.Type,
        at keyPath: KeyPath<T, U>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        var isLeaked = true
        let expect = expectation(description: "leak")
        
        viewController.hasLeakInLifeCycle(at: keyPath) {
            isLeaked = $0
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertFalse(isLeaked, file: file, line: line)
    }

}
