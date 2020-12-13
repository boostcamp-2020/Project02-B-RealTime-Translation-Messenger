//
//  MainCoordinating.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/05.
//

import UIKit

protocol MainCoordinating: class {
    func push(_ viewController: UIViewController)
    func present(_ viewController: UIViewController)
    
    func presentCodeInput()
    func pushChat(roomID: Int, code: String)
    func codeInputToChat(roomID: Int, code: String)
    func presentSetting()
}
