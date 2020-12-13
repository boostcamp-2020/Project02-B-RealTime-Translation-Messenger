//
//  SettingViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/12.
//

import UIKit
import ReactorKit
import RxCocoa

final class SettingViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var sizeSettingSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var micButtonDisplayView: UIView!
    @IBOutlet private weak var translationSettingSwitch: UISwitch!
    
    var microphoneButton = MicrophoneButton(mode: .none)
    var disposeBag = DisposeBag()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initailizeMicButton(by: .none)
        initailizeSizeSettingSegmentedControl()
    }
    
    func bind(reactor: SettingViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Input
    private func bindAction(reactor: SettingViewReactor) {
        sizeSettingSegmentedControl.rx.value
            .changed
            .map { Reactor.Action.sizeSegmentedControlChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        translationSettingSwitch.rx.value
            .changed
            .map { Reactor.Action.translationSettingSwitchChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    
}
