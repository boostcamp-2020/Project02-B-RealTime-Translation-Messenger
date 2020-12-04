//
//  SpeechManager.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import Speech
import RxSwift

final class SpeechManager: NSObject {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: UserDataProvider().language.locale)
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    let recognizedSpeech = BehaviorSubject<String>(value: "")
    let isAvailable = BehaviorSubject<Bool>(value: true)
    
    override init() {
        super.init()
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
            // Toast(text: "음성인식 기능의 오류가 발생하였습니다.\n앱을 재시작 해주세요.", delay: 0, duration: 2).show()
        }
    }
    
    private func configureRecognitionRequest() {
        let inputNode = audioEngine.inputNode
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else {
            debugPrint("SFSpeechAudioBufferRecognitionRequest create error")
            // Toast(text: "음성인식 기능의 오류가 발생하였습니다.\n다시 시작해주세요.", delay: 0, duration: 2).show()
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
            self?.audioEngine.stop()
            inputNode.removeTap(onBus: .zero)

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

extension SpeechManager: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        isAvailable.onNext(available)
    }
}
