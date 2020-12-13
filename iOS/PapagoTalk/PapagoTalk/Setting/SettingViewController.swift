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
    
    // MARK: - Output
    private func bindState(reactor: SettingViewReactor) {
        reactor.state.map { $0.microphoneButtonState }
            .distinctUntilChanged()
            .do(onNext: { [weak self] in
                self?.microphoneButton.mode = $0
            })
            .map { $0.index }
            .filter { [weak self] in
                self?.sizeSettingSegmentedControl.selectedSegmentIndex != $0
            }
            .subscribe(onNext: { [weak self] in
                self?.sizeSettingSegmentedControl.selectedSegmentIndex = $0
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.translationSetting }
            .distinctUntilChanged()
            .filter { [weak self] in
                self?.translationSettingSwitch.isOn != $0
            }
            .subscribe(onNext: { [weak self] in
                self?.translationSettingSwitch.isOn = $0
            })
            .disposed(by: disposeBag)
    }
    
    private func initailizeMicButton(by size: MicButtonSize) {
        micButtonDisplayView.addSubview(microphoneButton)
        
        microphoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            microphoneButton.centerXAnchor.constraint(equalTo: micButtonDisplayView.centerXAnchor),
            microphoneButton.centerYAnchor.constraint(equalTo: micButtonDisplayView.centerYAnchor)
        ])
    }
    
    private func initailizeSizeSettingSegmentedControl() {
        guard MicButtonSize.allCases.count <= sizeSettingSegmentedControl.numberOfSegments else {
            return
        }
        MicButtonSize.allCases.forEach {
            sizeSettingSegmentedControl.setTitle($0.description, forSegmentAt: $0.index)
        }
    }
}
