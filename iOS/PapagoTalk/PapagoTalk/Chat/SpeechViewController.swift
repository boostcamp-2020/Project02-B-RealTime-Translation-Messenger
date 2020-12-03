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
    
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var originSendButton: UIButton!
    @IBOutlet private weak var translatedSendButton: UIButton!
    @IBOutlet private weak var microphoneButton: UIButton!
    @IBOutlet private weak var originTextView: UITextView!
    @IBOutlet private weak var translatedTextView: UITextView!
    
    weak var delegate: SpeechViewDelegate?
    
    private let speechRecognizer = SFSpeechRecognizer(locale: UserDataProvider().language.locale)
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    let papago = PapagoAPIManager()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        reactor = SpeechViewReactor()
        bind()
    }
    
    func bind(reactor: SpeechViewReactor) {
        microphoneButton.rx.tap
            .do { [weak self] _ in
                self?.microphoneButtonTapped()
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        originTextView.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] in
                self?.papago.requestTranslation(request: TranslationRequest(source: "ko",
                                                                           target: "en",
                                                                           text: $0)) { result in
                    DispatchQueue.main.async {
                        self?.translatedTextView.text = result
                    }
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func bind() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    func microphoneButtonTapped() {
        guard audioEngine.isRunning else {
            startSpeechRecognizing()
            // button stop 모양
            microphoneButton.setTitle("stop", for: .normal)
            return
        }
        stopSpeechRecognizing()
    }
    
    private func stopSpeechRecognizing() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        // button microphone 모양
        microphoneButton.setTitle("", for: .normal)
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
            debugPrint("AudioSession setting error")
            Toast(text: "음성인식 기능의 오류가 발생하였습니다.\n앱을 재시작 해주세요.", delay: 0, duration: 2).show()
        }
    }
    
    private func configureRecognitionRequest() {
        let inputNode = audioEngine.inputNode
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            debugPrint("SFSpeechAudioBufferRecognitionRequest create error")
            Toast(text: "음성인식 기능의 오류가 발생하였습니다.\n다시 시작해주세요.", delay: 0, duration: 2).show()
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        configureRecognitionTask(by: recognitionRequest, on: inputNode)
    }
    
    private func configureRecognitionTask(by request: SFSpeechAudioBufferRecognitionRequest,
                                          on inputNode: AVAudioInputNode) {
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            var isFinal = false
            
            if result != nil {
                self.originTextView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: .zero)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.microphoneButton.isEnabled = true
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
    
    private func dismiss() {
        guard let superview = view.superview else { return }
        UIView.transition(with: superview,
                          duration: 0.4,
                          options: [.transitionCrossDissolve]) { [weak self] in
            self?.view.removeFromSuperview()
        } completion: { [weak self] _ in
            self?.delegate?.speechViewDidDismiss()
        }
        
        view.removeFromSuperview()
        removeFromParent()
        dismiss(animated: true)
    }
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

