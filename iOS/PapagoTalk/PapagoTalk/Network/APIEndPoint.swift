//
//  EndPoint.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/25.
//

import Foundation

struct APIEndPoint {
    
    static let baseURL = "49.50.164.243:3000/graphql"
    //static let baseURL = "www.papagotalk.kro.kr:3000/graphql"
    
    static var requestURL: URL {
        URL(string: "http://" + baseURL)!
    }
    
    static var socketURL: URL {
        URL(string: "ws://" + baseURL)!
    }

    static let naverPapagoOpenAPI = URL(string: "https://openapi.naver.com/v1/papago/n2mt")!
    static let naverPapagoOpenAPIclientID = ""
    static let naverPapagoOpenAPIclientSecret = ""
    
    static let ncpPapagoAPI = URL(string: "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation")!
    static let ncpPapagoAPIclientID = ""
    static let ncpPapagoAPIclientSecret = ""
}
