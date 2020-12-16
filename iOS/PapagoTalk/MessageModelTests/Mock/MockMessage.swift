//
//  MockMessage.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import Foundation

struct MockMessage: MessageData {
    var id: Int
    var text: String
    var userData: UserData
    var source: String
    var createdAt: String? 
}
