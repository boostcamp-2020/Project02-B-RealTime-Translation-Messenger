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
    
    let microphoneButton = UIButton()
    let myTextView = UITextView()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.autoupdatingCurrent)
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
    }
    
    func bind(reactor: SpeechViewReactor) {
        microphoneButton.rx.tap
            .do { [weak self] _ in
                self?.microphoneButtonTapped()
            }
            .subscribe()
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
