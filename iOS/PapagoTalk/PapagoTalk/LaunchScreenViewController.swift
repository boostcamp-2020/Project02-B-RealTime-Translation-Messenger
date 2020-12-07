//
//  LaunchScreenViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/07.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = UIColor.systemPink
        }, completion: { _ in
            self.view.window?.rootViewController = self.coordinator!.navigationController
        })
    }
}
