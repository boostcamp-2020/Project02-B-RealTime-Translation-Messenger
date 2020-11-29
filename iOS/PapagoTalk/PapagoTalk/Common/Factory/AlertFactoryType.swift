//
//  AlertFactoryType.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/29.
//

import UIKit

protocol AlertFactoryType {
    func alert(message: String) -> UIAlertController
}
