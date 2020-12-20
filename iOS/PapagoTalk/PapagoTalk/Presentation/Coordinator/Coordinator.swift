//
//  Coordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

protocol Coordinator {
    var storyboard: UIStoryboard { get }
    
    func start()
}

extension Coordinator {
    var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
}
