//
//  HistorySection.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import RxDataSources

struct HistorySection {
    var header: String
    var items: [Item]
}

extension HistorySection: SectionModelType {
    
    typealias Item = ChatRoomHistory
    
    init(original: HistorySection, items: [Item]) {
        self = original
        self.items = items
    }
    
    init(items: [Item]) {
        self.header = String(describing: Self.self)
        self.items = items
    }
}
