//
//  SpeechService.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import Speech
import RxSwift

final class SpeechService: NSObject, SpeechServiceProviding {
    
    private let userData: UserDataProviding
    private var speechRecognizer: SFSpeechRecognizer?
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    var recognizedSpeech = BehaviorSubject<String>(value: "")
    var isAvailable = BehaviorSubject<Bool>(value: true)
    
    init(userData: UserDataProviding) {
        self.userData = userData
        super.init()
        speechRecognizer = SFSpeechRecognizer(locale: userData.language.locale)
        speechRecognizer?.delegate = self
    }
    
    func speechToText() {
        guard audioEngine.isRunning else {
            self.startSpeechRecognizing()
            return
        }
        stopSpeechRecognizing()
    }
    
    private func startSpeechRecognizing() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        configureAVAudioSession()
        configureRecognitionRequest()
    }
    
    private func stopSpeechRecognizing() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: .zero)
        recognitionRequest?.endAudio()
    }
    
    private func configureAVAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func configureRecognitionRequest() {
        let inputNode = audioEngine.inputNode
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else {
            debugPrint("SFSpeechAudioBufferRecognitionRequest create error")
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        configureRecognitionTask(by: recognitionRequest, on: inputNode)
    }
    
    private func configureRecognitionTask(by request: SFSpeechAudioBufferRecognitionRequest,
                                          on inputNode: AVAudioInputNode) {
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { [weak self] result, error in
            var isFinal = false
            
            if let result = result {
                self?.recognizedSpeech.onNext(result.bestTranscription.formattedString)
                isFinal = result.isFinal
            }
            
            guard error != nil || isFinal else {
                return
            }
            self?.stopSpeechRecognizing()
            self?.recognitionRequest = nil
            self?.recognitionTask = nil
        })
        configureAdditionalSpeechInput(on: inputNode)
    }
    
    private func configureAdditionalSpeechInput(on inputNode: AVAudioInputNode) {
        let recordingFormat = inputNode.outputFormat(forBus: .zero)
        inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

extension SpeechService: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        isAvailable.onNext(available)
    }
}
