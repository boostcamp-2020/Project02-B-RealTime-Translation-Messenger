//
//  MessageSection.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/10.
//

import Foundation
import RxDataSources

struct MessageSection {
    var header: String
    var items: [Item]
}

extension MessageSection: SectionModelType {
    
    typealias Item = Message
    
    init(original: MessageSection, items: [Item]) {
        self = original
        self.items = items
    }
    
    init(items: [Item]) {
        self.header = String(describing: Self.self)
        self.items = items
    }
}
