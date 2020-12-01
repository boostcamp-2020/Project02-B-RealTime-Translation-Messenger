//
//  MainCoordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var networkService: NetworkServiceProviding
    var userData: UserDataProviding
    var alertFactory: AlertFactoryProviding
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController,
         networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         alertFactory: AlertFactoryProviding) {
        
        self.navigationController = navigationController
        self.networkService = networkService
        self.userData = userData
        self.alertFactory = alertFactory
    }
    
    func start() {
        let viewController = storyboard.instantiateViewController(
            identifier: HomeViewController.identifier,
            creator: { [unowned self] coder -> HomeViewController? in
                let reactor = HomeViewReactor(networkService: networkService, userData: userData)
                return HomeViewController(coder: coder,
                                          reactor: reactor,
                                          alertFactory: alertFactory)
            }
        )
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator {
    
    func codeInputToChat(roomID: Int) {
        navigationController.presentedViewController?.dismiss(animated: true, completion: { [weak self] in
            self?.showChat(roomID: roomID)
        })
        
    }
    
    func showChat(roomID: Int) {
        let viewController = storyboard.instantiateViewController(
            identifier: ChatViewController.identifier,
            creator: { [unowned self] coder -> ChatViewController? in
                let reactor = ChatViewReactor(networkService: networkService,
                                              userData: userData,
                                              roomID: roomID)
                return ChatViewController(coder: coder, reactor: reactor)
            }
        )
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showChatCodeInput() {
        let viewController = storyboard.instantiateViewController(
            identifier: ChatCodeInputViewController.identifier,
            creator: { [unowned self] coder -> ChatCodeInputViewController? in
                let reacter = ChatCodeInputReactor(networkService: networkService, userData: userData)
                return ChatCodeInputViewController(coder: coder,
                                                   reactor: reacter,
                                                   alertFactory: alertFactory)
            }
        )
        viewController.coordinator = self
        navigationController.present(viewController, animated: true)
    }
    
}
