//
//  AlertFactory.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/29.
//

import UIKit

struct AlertFactory: AlertFactoryProviding {
    
    func alert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Strings.ok, style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
