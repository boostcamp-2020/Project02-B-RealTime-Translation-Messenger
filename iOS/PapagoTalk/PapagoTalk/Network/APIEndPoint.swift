//
//  EndPoint.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/25.
//

import Foundation

struct APIEndPoint {
    static let baseURL = "www.madagascar.kro.kr:3000/"
    static var requestURL: String {
        "http://" + baseURL
    }
    static var socketURL: String {
        "ws://" + baseURL
    }
}
