//
//  LanguageSelectionView.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LanguageSelectionView: UIViewController {
    
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    
    var disposeBag = DisposeBag()
    var pickerViewObserver: BehaviorSubject<Language>?
    @UserDefault(type: .userInfo, default: User()) var user: User
    
    override func viewDidLoad() {
        configurePickerView()
        bind()
        initializePickerView(at: user.language.index)
    }
    
    private func configurePickerView() {
        Observable.just(Language.allCases)
            .bind(to: pickerView.rx.itemTitles) { _, item in
                item.localizedText
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        guard let observer = pickerViewObserver else {
            return
        }
        
        confirmButton.rx.tap
            .withLatestFrom(pickerView.rx.modelSelected(Language.self))
            .map { $0[0] }
            .do { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    private func initializePickerView(at index: Int) {
        pickerView.selectRow(index, inComponent: 0, animated: true)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: index, inComponent: 0)
    }
}
