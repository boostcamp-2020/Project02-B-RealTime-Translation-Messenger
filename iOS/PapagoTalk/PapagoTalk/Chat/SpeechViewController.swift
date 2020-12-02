//
//  SpeechViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import UIKit
import Speech
import ReactorKit
import RxCocoa
import Toaster

final class SpeechViewController: UIViewController, StoryboardView {
    
    
}

extension SpeechViewController: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        guard available else {
            microphoneButton.isEnabled = false
            return
        }
        microphoneButton.isEnabled = true
    }
}
