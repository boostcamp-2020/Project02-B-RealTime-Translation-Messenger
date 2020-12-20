//
//  KeyboardProviding.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/30.
//

import RxSwift
import RxCocoa
import RxGesture

protocol KeyboardProviding: UIViewController {
    var tapToDissmissKeyboard: Driver<Void.Type> { get }
    var keyboardWillShow: Driver<CGRect> { get }
}

extension KeyboardProviding {
    var tapToDissmissKeyboard: Driver<Void.Type> {
        return view.rx.tapGesture()
            .when(.recognized)
            .map { _ in Void.self }
            .do(onNext: { [weak self] _ in
                    self?.view.endEditing(true)
            })
            .asDriver(onErrorJustReturn: Void.self)
    }
    
    var keyboardWillShow: Driver<CGRect> {
        return NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .asObservable()
            .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue }
            .asDriver(onErrorJustReturn: .zero)
    }
    
    var keyboardWillHide: Driver<CGRect> {
        return NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .asObservable()
            .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue }
            .asDriver(onErrorJustReturn: .zero)
    }
}
