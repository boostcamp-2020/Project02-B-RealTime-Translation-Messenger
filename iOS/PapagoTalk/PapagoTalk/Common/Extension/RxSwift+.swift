//
//  RxSwift+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/27.
//

import RxSwift

///
/// 출처 : https://github.com/pixeldock/RxAppState
///
extension RxSwift.Reactive where Base: UIViewController {
    
    var viewDidLoad: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { _ in return }
    }
    
    var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
}
