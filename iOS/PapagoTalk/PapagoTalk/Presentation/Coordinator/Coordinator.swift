//
//  Coordinator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

protocol Coordinator {
    func start()
    var storyboard: UIStoryboard { get }
}

extension Coordinator {
    var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
}
