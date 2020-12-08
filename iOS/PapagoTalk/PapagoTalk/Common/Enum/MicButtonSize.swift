//
//  MicButtonSize.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/09.
//

import UIKit

enum MicButtonSize: Int, Codable {
    case big
    case midium
    case small
    case none
    
    var size: CGFloat {
        switch self {
        case .big:
            return 70
        case .midium:
            return 60
        case .small:
            return 50
        case .none:
            return 0
        }
    }
}
