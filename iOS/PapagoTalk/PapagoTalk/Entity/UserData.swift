//
//  UserData.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/11.
//

import Foundation

protocol UserData {
    var id: Int { get set }
    var nickname: String { get set }
    var avatar: String { get set }
    var lang: String { get set }
}
