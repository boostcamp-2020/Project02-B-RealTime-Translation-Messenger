//
//  HomeCoordinating.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/05.
//

import UIKit
import RxSwift

protocol HomeCoordinating: class {
    func presentCodeInput()
    func pushChat(roomID: Int, code: String)
    func presentLanguageSelectionView(observer: BehaviorSubject<Language>)
    func pushSetting()
}
