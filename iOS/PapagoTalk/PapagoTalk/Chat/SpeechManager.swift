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
    private var speechToTextHandler: ((String) -> Void)?
    var ob = BehaviorSubject<String>(value: "")
    
    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }
    
    func speechToText() {
        guard audioEngine.isRunning else {
//            speechToTextHandler = handler
            DispatchQueue.main.async { [weak self] in
                self?.startSpeechRecognizing()
            }
            // microphoneButton.setTitle("stop", for: .normal)
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
        // microphoneButton.setTitle("start", for: .normal)
    }
    
    private func configureAVAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        DispatchQueue.main.async {
            do {
                try audioSession.setCategory(AVAudioSession.Category.record)
                try audioSession.setMode(AVAudioSession.Mode.measurement)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                debugPrint(error.localizedDescription)
                debugPrint("AVAudio")
                // Toast(text: "음성인식 기능의 오류가 발생하였습니다.\n앱을 재시작 해주세요.", delay: 0, duration: 2).show()
            }
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
            
            if let result = result, let handler = self?.speechToTextHandler {
                let output = result.bestTranscription.formattedString
                isFinal = result.isFinal
                self?.ob.onNext(output)
            }
            
            guard error != nil || isFinal else {
                debugPrint("없음")
                return
            }
            self?.audioEngine.stop()
            inputNode.removeTap(onBus: .zero)

            self?.recognitionRequest = nil
            self?.recognitionTask = nil
            // self?.microphoneButton.isEnabled = true
        })
        configureAdditionalSpeechInput(on: inputNode)
    }
    
    private func configureAdditionalSpeechInput(on inputNode: AVAudioInputNode) {
        let recordingFormat = inputNode.outputFormat(forBus: .zero)
        inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        DispatchQueue.main.async { [weak self] in
            self?.audioEngine.prepare()
            do {
                try self?.audioEngine.start()
            } catch {
                debugPrint(error.localizedDescription)
                debugPrint("마지막")
            }
        }
    }
}

extension SpeechManager: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        debugPrint("델리게이트 작동됨 ")
        guard available else {
            // microphoneButton.isEnabled = false
            return
        }
        // microphoneButton.isEnabled = true
    }
}
