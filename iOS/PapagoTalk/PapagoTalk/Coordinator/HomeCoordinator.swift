//
//  HomeCoordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/05.
//

import UIKit
import RxSwift

final class HomeCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinating?
    
    var networkService: NetworkServiceProviding
    var userData: UserDataProviding
    var alertFactory: AlertFactoryProviding
    
    init(networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         alertFactory: AlertFactoryProviding) {
        
        self.networkService = networkService
        self.userData = userData
        self.alertFactory = alertFactory
    }
    
    func start() {
        let homeViewController = storyboard.instantiateViewController(
            identifier: HomeViewController.identifier,
            creator: { [unowned self] coder -> HomeViewController? in
                let reactor = HomeViewReactor(networkService: networkService, userData: userData)
                return HomeViewController(coder: coder,
                                          reactor: reactor,
                                          alertFactory: alertFactory,
                                          currentLanguage: userData.language)
            }
        )
        homeViewController.coordinator = self
        parentCoordinator?.push(homeViewController)
    }
}

extension HomeCoordinator: HomeCoordinating {
    func presentLanguageSelectionView(observer: BehaviorSubject<Language>) {
        let viewController =
            storyboard.instantiateViewController(
                identifier: LanguageSelectionViewController.identifier,
                creator: { [unowned self] coder -> LanguageSelectionViewController? in
                    return LanguageSelectionViewController(coder: coder,
                                                           userData: userData,
                                                           observer: observer)
                }
            )
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(viewController, forKey: "contentViewController")
        parentCoordinator?.present(alertController)
    }
    
    func presentCodeInput() {
        parentCoordinator?.presentCodeInput()
    }
    
    func pushChat(roomID: Int, code: String) {
        parentCoordinator?.pushChat(roomID: roomID, code: code)
    }
    
    func presentSetting() {
        parentCoordinator?.presentSetting()
    }
}
