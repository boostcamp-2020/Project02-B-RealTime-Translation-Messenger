//
//  MessageData.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/11.
//

import Foundation

protocol MessageData {
    var id: Int { get set }
    var text: String { get set }
    var userData: UserData { get }
    var source: String { get set }
    var createdAt: String? { get set }
}
