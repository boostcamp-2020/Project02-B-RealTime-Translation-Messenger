//
//  StubImageFactory.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation
@testable import PapagoTalk

struct StubImageFactory: ImageFactoryProviding {
    
    func randomImageURL() -> String {
        return "1.png"
    }
}
