//
//  MainCoordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit
import RxCocoa

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var networkService: NetworkServiceProviding
    var userData: UserDataProviding
    var alertFactory: AlertFactoryProviding
    var messageParser: MessageParseProviding
    var historyManager: HistoryServiceProviding
    var childCoordinator: [Coordinator] = []
    
    init(navigationController: UINavigationController,
         networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         alertFactory: AlertFactoryProviding,
         messageParser: MessageParser,
         historyManager: HistoryServiceProviding) {
        
        self.navigationController = navigationController
        self.networkService = networkService
        self.userData = userData
        self.alertFactory = alertFactory
        self.messageParser = messageParser
        self.historyManager = historyManager
        
        configureNavigationItem()
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(networkService: networkService,
                                              userData: userData,
                                              alertFactory: alertFactory,
                                              historyManager: historyManager)
        
        let chatCoordinator = ChatCoordinator(networkService: networkService,
                                              userData: userData,
                                              messageParser: messageParser,
                                              historyManager: historyManager)
        
        homeCoordinator.parentCoordinator = self
        chatCoordinator.parentCoordinator = self
        childCoordinator.append(homeCoordinator)
        childCoordinator.append(chatCoordinator)
        
        homeCoordinator.start()
    }
    
    private func configureNavigationItem() {
        navigationController.navigationBar.barTintColor = UIColor(named: "NavigationBarColor")
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = UIColor(named: "PapagoBlue")
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
    
    func pushSetting(_ micButtonSizeObserver: BehaviorRelay<MicButtonSize>?) {
        let viewController = storyboard.instantiateViewController(
            identifier: SettingViewController.identifier,
            creator: { [unowned self] coder -> SettingViewController? in
                let reacter = SettingViewReactor(userData: userData)
                return SettingViewController(coder: coder, reactor: reacter, micButtonObserver: micButtonSizeObserver)
            }
        )
        push(viewController)
    }
    
    func presentCodeInput() {
        let viewController = storyboard.instantiateViewController(
            identifier: ChatCodeInputViewController.identifier,
            creator: { [unowned self] coder -> ChatCodeInputViewController? in
                let reacter = ChatCodeInputViewReactor(networkService: networkService, userData: userData)
                return ChatCodeInputViewController(coder: coder, reactor: reacter, alertFactory: alertFactory)
            }
        )
        viewController.coordinator = self
        navigationController.present(viewController, animated: true)
    }
}
