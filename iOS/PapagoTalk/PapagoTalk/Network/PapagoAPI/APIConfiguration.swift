//
//  APIConfiguration.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/20.
//

import Foundation

protocol APIConfiguration {
    var url: URL { get set }
    var httpMethod: HTTPMethod { get set }
    var headers: [String: String] { get set }
    var body: Data? { get set }
}
