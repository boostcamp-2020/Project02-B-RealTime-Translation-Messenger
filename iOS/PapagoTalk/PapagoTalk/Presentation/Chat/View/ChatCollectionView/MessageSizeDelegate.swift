//
//  MessageSizeDelegate.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/11.
//

import UIKit
import RxSwift

final class MessageSizeDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    let calculator = MessageHeightCalculator()
    var messageSizes = [CGFloat]()
    
    func updateSizes(messages: [Message]) {
        guard messageSizes.count < messages.count else {
            return
        }
        let start = messageSizes.count
        let end = messages.count - 1
        
        let newHeights = messages[start...end].map { calculator.height(of: $0) }
        messageSizes.append(contentsOf: newHeights)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard messageSizes.count > indexPath.row else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: messageSizes[indexPath.row])
    }
}
