//
//  SpeechManager.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import Speech

final class SpeechManager: NSObject {
    
   
}

extension SpeechManager: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        guard available else {
            // microphoneButton.isEnabled = false
            return
        }
        // microphoneButton.isEnabled = true
    }
}
