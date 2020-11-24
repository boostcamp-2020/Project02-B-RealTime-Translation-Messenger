//
//  LanguagePickerView.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class LanguageSelectionView: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var disposeBag = DisposeBag()
    var pickerViewObserver: BehaviorSubject<Language>?
    
    override func viewDidLoad() {
        configurePickerView()
        bind()
        initialSelect(index: 0)
    }
    
    private func configurePickerView() {
        Observable.just(Language.allCases)
            .bind(to: pickerView.rx.itemTitles) { _, item in
                item.localizedText
            }
            .disposed(by: disposeBag)
    }
    
    private func initialSelect(index: Int) {
        pickerView.selectRow(index, inComponent: 0, animated: true)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: index, inComponent: 0)
    }
    
    private func bind() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        if let observer = pickerViewObserver {
            confirmButton.rx.tap
                .withLatestFrom(pickerView.rx.modelSelected(Language.self))
                .map { $0[0] }
                .do { [weak self] _ in self?.dismiss(animated: true, completion: nil) }
                .bind(to: observer)
                .disposed(by: disposeBag)
        }
    }
    
}
