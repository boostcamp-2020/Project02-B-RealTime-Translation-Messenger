//
//  HistoryServiceProviding.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import Foundation

protocol HistoryServiceProviding {
    func fetch() -> [ChatRoomHistory]
    func insert(of history: ChatRoomHistory)
}
