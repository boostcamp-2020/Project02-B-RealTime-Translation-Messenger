//
//  UserDataSource.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/10.
//

import Foundation
import RxDataSources

class UserDataSource: RxCollectionViewSectionedReloadDataSource<UserSection> {
    
    init() {
        super.init(configureCell: { _, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatDrawerUserCell.identifier,
                                                                for: indexPath) as? ChatDrawerUserCell else {
                return UICollectionViewCell()
            }
            cell.configureUserCell(with: item)
            return cell
        })
    }
}
