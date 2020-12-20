//
//  MockMessageData.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import Foundation

struct MockMessageData: MessageData {
    
    var id: Int
    var text: String
    var userData: UserData
    var source: String
    var createdAt: String?
    
    init(id: Int, text: String, userData: UserData, source: String, createdAt: String?) {
        self.id = id
        self.text = text
        self.userData = userData
        self.source = source
        self.createdAt = createdAt
    }
    
    init(userData: UserData) {
        self.id = 0
        self.text = "test"
        self.userData = userData
        self.source = "ko"
    }
    
    init() {
        id = 0
        text = "test"
        userData = MockUserData()
        source = "ko"
    }
}
