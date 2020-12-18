//
//  MockSpeechManager.swift
//  PapagoTalkTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/08.
//

import Foundation
import RxSwift
@testable import PapagoTalk

class MockSpeechManager: SpeechServiceProviding {
    var recognizedSpeech: BehaviorSubject<String> = BehaviorSubject(value: "")
    var isAvailable: BehaviorSubject<Bool>  = BehaviorSubject(value: true)
    
    func speechToText() {
        recognizedSpeech.onNext("RecognizedText")
    }
}
