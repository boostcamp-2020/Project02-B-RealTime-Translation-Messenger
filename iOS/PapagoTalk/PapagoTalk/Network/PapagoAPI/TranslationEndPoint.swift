//
//  TranslationEndPoint.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/20.
//

import Foundation

struct TranslationEndPoint: APIConfiguration {
    
    /// NCP PapagoNMT
    var url = URL(string: "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation")!
    var httpMethod: HTTPMethod = .post
    var headers = [
        "Content-Type": "application/json",
        "X-NCP-APIGW-API-KEY-ID": "",
        "X-NCP-APIGW-API-KEY": ""
    ]
    
    var body: Data?
    
    init(body: Data?) {
        self.body = body
    }
}
