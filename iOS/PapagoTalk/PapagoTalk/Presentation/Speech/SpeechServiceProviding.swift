//
//  SpeechServiceProviding.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/08.
//

import RxSwift

protocol SpeechServiceProviding {
    func speechToText()
    
    var recognizedSpeech: BehaviorSubject<String> { get set }
    var isAvailable: BehaviorSubject<Bool> { get set }
}
