//
//  Coordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start() 
}
