//
//  MicButtonSize.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/09.
//

import UIKit

enum MicButtonSize: Int, Codable, CaseIterable {
    case big
    case medium
    case small
    case none
    
    var size: CGFloat {
        switch self {
        case .big:
            return 70
        case .medium:
            return 60
        case .small:
            return 50
        case .none:
            return 0
        }
    }
    
    var index: Int {
        switch self {
        case .big:
            return 0
        case .medium:
            return 1
        case .small:
            return 2
        case .none:
            return 3
        }
    }
    
    var description: String {
        switch self {
        case .big:
            return "Big".localized
        case .medium:
            return "Medium".localized
        case .small:
            return "Small".localized
        case .none:
            return "None".localized
        }
    }
    
    static func indexToType(of index: Int) -> MicButtonSize {
        switch index {
        case 0:
            return .big
        case 1:
            return .medium
        case 2:
            return .small
        case 3:
            return .none
        default:
            return .none
        }
    }
}
