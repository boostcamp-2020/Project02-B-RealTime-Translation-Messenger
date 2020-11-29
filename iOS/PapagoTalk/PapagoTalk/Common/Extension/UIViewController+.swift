//
//  UIViewController+.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import UIKit

extension UIViewController {
    
    @UserDefault(type: .userInfo, default: User()) static var user: User
    
    static var identifier: String {
        String(describing: Self.self)
    }
}
