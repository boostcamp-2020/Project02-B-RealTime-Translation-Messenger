//
//  SceneDelegate.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let networkService = NetworkService()
        let alertFactory = AlertFactory()
        let userData = UserDataProvider()
        let messageParser = MessageParser(userData: userData)
        let persistenceManager = PersistenceManager(name: "HistoryModel")
        let historyManager = HistoryManager(persistenceManager: persistenceManager)
        
        window = UIWindow(windowScene: scene)
        coordinator = MainCoordinator(navigationController: navigationController,
                                      networkService: networkService,
                                      userData: userData,
                                      alertFactory: alertFactory,
                                      messageParser: messageParser,
                                      historyManager: historyManager)
        coordinator?.start()
        
        guard let launchScreenViewContorller =
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                    identifier: LaunchScreenViewController.identifier) as? LaunchScreenViewController else {
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            return
        }
        launchScreenViewContorller.coordinator = coordinator
        window?.rootViewController = launchScreenViewContorller
        window?.makeKeyAndVisible()
    }
}
