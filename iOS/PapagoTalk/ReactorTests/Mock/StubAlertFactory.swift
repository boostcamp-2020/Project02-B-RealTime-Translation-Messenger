//
//  StubAlertFactory.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import UIKit
@testable import PapagoTalk

struct StubAlertFactory: AlertFactoryProviding {
    
    func alert(message: String) -> UIAlertController {
        return UIAlertController()
    }
}
