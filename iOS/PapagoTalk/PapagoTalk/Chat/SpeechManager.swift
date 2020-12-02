//
//  SpeechManager.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import Speech

final class SpeechManager: NSObject {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.autoupdatingCurrent)
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    var outputText: String?
    
    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }
    
    func speechToText() {
        guard audioEngine.isRunning else {
            startSpeechRecognizing()
            // microphoneButton.setTitle("stop", for: .normal)
            return
        }
        stopSpeechRecognizing()
    }
    
    private func stopSpeechRecognizing() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        // microphoneButton.setTitle("start", for: .normal)
    }
    
    private func startSpeechRecognizing() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        configureAVAudioSession()
        configureRecognitionRequest()
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
            
            if result != nil {
                self?.outputText = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self?.audioEngine.stop()
                inputNode.removeTap(onBus: .zero)
                self?.recognitionRequest = nil
                self?.recognitionTask = nil
                // self?.microphoneButton.isEnabled = true
            }
        })
        configureAdditionalSpeechInput(on: inputNode)
    }
    
    private func configureAdditionalSpeechInput(on inputNode: AVAudioInputNode) {
        let recordingFormat = inputNode.outputFormat(forBus: .zero)
        inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
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
        guard available else {
            // microphoneButton.isEnabled = false
            return
        }
        // microphoneButton.isEnabled = true
    }
}
