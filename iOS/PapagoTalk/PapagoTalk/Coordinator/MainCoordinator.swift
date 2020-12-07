//
//  MainCoordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var networkService: NetworkServiceProviding
    var userData: UserDataProviding
    var alertFactory: AlertFactoryProviding
    var translationManager: PapagoAPIServiceProviding
    var speechManager: SpeechManager
    var messageParser: MessageParser
    var childCoordinator: [Coordinator] = []
    
    init(navigationController: UINavigationController,
         networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         alertFactory: AlertFactoryProviding,
         translationManager: PapagoAPIServiceProviding,
         speechManager: SpeechManager,
         messageParser: MessageParser) {
        
        self.navigationController = navigationController
        self.networkService = networkService
        self.userData = userData
        self.alertFactory = alertFactory
        self.translationManager = translationManager
        self.speechManager = speechManager
        self.messageParser = messageParser
        
        navigationController.navigationBar.barTintColor = UIColor(named: "NavigationBarColor")
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = UIColor(named: "PapagoBlue")
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(networkService: networkService,
                                              userData: userData,
                                              alertFactory: alertFactory)
        
        let chatCoordinator = ChatCoordinator(networkService: networkService,
                                              userData: userData,
                                              translationManager: translationManager,
                                              speechManager: speechManager,
                                              messageParser: messageParser)
        
        homeCoordinator.parentCoordinator = self
        chatCoordinator.parentCoordinator = self
        childCoordinator.append(homeCoordinator)
        childCoordinator.append(chatCoordinator)
        
        homeCoordinator.start()
    }
}

extension MainCoordinator: MainCoordinating {
    
    func push(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController) {
        navigationController.viewControllers.last?.present(viewController, animated: true)
    }
   
    func codeInputToChat(roomID: Int, code: String) {
        navigationController.presentedViewController?.dismiss(animated: true, completion: { [weak self] in
            self?.pushChat(roomID: roomID, code: code)
        })
    }
    
    func pushChat(roomID: Int, code: String) {
        guard let chatCoordinator = childCoordinator[1] as? ChatCoordinator else {
            return
        }
        chatCoordinator.roomID = roomID
        chatCoordinator.code = code
        chatCoordinator.start()
    }
    
    func presentCodeInput() {
        let viewController = storyboard.instantiateViewController(
            identifier: ChatCodeInputViewController.identifier,
            creator: { [unowned self] coder -> ChatCodeInputViewController? in
                let reacter = ChatCodeInputViewReactor(networkService: networkService, userData: userData)
                return ChatCodeInputViewController(coder: coder,
                                                   reactor: reacter,
                                                   alertFactory: alertFactory)
            }
        )
        viewController.coordinator = self
        navigationController.present(viewController, animated: true)
    }
}
