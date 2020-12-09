//
//  MessageDataSource.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/10.
//

import Foundation
import RxDataSources

class MessageDataSource: RxCollectionViewSectionedReloadDataSource<MessageSection> {
    init() {
        super.init(configureCell: { _, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.type.identifier,
                                                                for: indexPath) as? MessageCell else {
                return UICollectionViewCell()
            }
            cell.configureMessageCell(message: item)
            return cell
        })
    }
}
