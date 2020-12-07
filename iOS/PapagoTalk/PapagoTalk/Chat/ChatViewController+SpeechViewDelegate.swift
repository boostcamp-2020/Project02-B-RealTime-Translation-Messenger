//
//  ChatViewController+SpeechViewDelegate.swift
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
    
    func speechViewDidDismiss() {
        microphoneButton.moveToLatest()
    }
}
