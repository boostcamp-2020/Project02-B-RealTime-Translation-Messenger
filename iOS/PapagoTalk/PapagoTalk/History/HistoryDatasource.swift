//
//  HistoryDatasource.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import Foundation
import RxDataSources

class HistoryDatasource: RxTableViewSectionedReloadDataSource<HistorySection> {
    
    init() {
        super.init(configureCell: { _, tableview, indexPath, item in
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
                return UITableViewCell()
            }
            cell.configure(with: item)
            return cell
        })
    }
}
