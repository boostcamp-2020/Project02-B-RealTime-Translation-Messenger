//
//  RevisionedData.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/04.
//

import Foundation

struct RevisionedData<T>: Equatable {
    
    fileprivate let revision: UInt
    let data: T?
    
    init(revision: UInt, data: T?) {
        self.revision = revision
        self.data = data
    }
    
    init(data: T?) {
        self.revision = .zero
        self.data = data
    }
    
    static func == (lhs: RevisionedData, rhs: RevisionedData) -> Bool {
        lhs.revision == rhs.revision
    }
}

extension RevisionedData {
    func update(_ data: T?) -> RevisionedData {
        return RevisionedData<T>(revision: self.revision + 1, data: data) }
    
    func update() -> RevisionedData {
        return RevisionedData<T>(revision: self.revision + 1, data: self.data)
    }
}
