//
//  ChatCoordinating.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/05.
//

import UIKit
import RxCocoa

protocol ChatCoordinating: class {
    func presentSpeech(from presentingViewController: UIViewController)
    func presentDrawer(from presentingViewController: UIViewController,
                       with stateObserver: BehaviorRelay<Bool>,
                       micButtonSizeObserver: BehaviorRelay<MicButtonSize>)
}
