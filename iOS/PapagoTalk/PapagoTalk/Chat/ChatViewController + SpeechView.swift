//
//  ChatViewController + SpeechView.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/02.
//

import UIKit

extension ChatViewController: SpeechViewDelegate {
    func attachMicrophoneButton() {
        let origin = CGPoint(x: view.frame.width - 80, y: view.frame.height - 200)
        microphoneButton = MicrophoneButton(mode: .small, origin: origin)
        view.addSubview(microphoneButton)
    }
    
    func showSpeechView(roomID: Int) {
        guard let speechViewController = storyboard?.instantiateViewController(identifier: SpeechViewController.identifier) as? SpeechViewController else {
            return
        }
        speechViewController.delegate = self
        speechViewController.roomID = roomID
        addChild(speechViewController)
        speechViewController.view.frame = CGRect(x: (view.frame.width - Constant.speechViewWidth)/2.0,
                                                 y: (view.frame.height - Constant.speechViewHeight)/2.0,
                                                 width: Constant.speechViewWidth,
                                                 height: Constant.speechViewHeight)
        UIView.transition(with: self.view,
                          duration: 0.4,
                          options: [.transitionCrossDissolve]) { [weak self] in
            self?.view.addSubview(speechViewController.view)
        }
    }
    
    func speechViewDidDismiss() {
        microphoneButton.moveToLatest()
    }
}
