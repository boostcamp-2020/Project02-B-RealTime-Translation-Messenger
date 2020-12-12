//
//  UserSection.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/10.
//

import Foundation
import RxDataSources

struct UserSection {
    var header: String
    var items: [Item]
}

extension UserSection: SectionModelType {
    
    typealias Item = User
    
    init(original: UserSection, items: [Item]) {
        self = original
        self.items = items
    }
    
    init(items: [Item]) {
        self.header = String(describing: Self.self)
        self.items = items
    }
}
