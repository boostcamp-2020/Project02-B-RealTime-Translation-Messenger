//
//  LanguageSelectionView.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LanguageSelectionViewController: UIViewController {
    
    @IBOutlet private weak var pickerView: LanguagePickerView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private let userData: UserDataProviding
    var pickerViewObserver: BehaviorSubject<Language>
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder,
          userData: UserDataProviding,
          observer: BehaviorSubject<Language>) {
        self.userData = userData
        self.pickerViewObserver = observer
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        userData = UserDataProvider()
        pickerViewObserver = BehaviorSubject(value: Language.english)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        configurePickerView()
        bind()
        initializePickerView(at: userData.user.language.index)
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
        
        confirmButton.rx.tap
            .withLatestFrom(pickerView.rx.modelSelected(Language.self))
            .compactMap { $0.first }
            .do(afterNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .bind(to: pickerViewObserver)
            .disposed(by: disposeBag)
    }
    
    private func initializePickerView(at index: Int) {
        pickerView.selectRow(index, inComponent: .zero, animated: true)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: index, inComponent: .zero)
    }
}
