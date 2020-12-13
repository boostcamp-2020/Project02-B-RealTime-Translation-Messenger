//
//  HistoryViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import UIKit
import ReactorKit
import RxCocoa
import RxDataSources
import CoreData

final class HistoryViewController: UIViewController, StoryboardView {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    let datasource = HistoryDatasource()
    var disposeBag = DisposeBag()
    weak var coordinator: HomeCoordinating?
    
    init?(coder: NSCoder, reactor: HistoryViewReactor) {
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind(reactor: HistoryViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Input
    private func bindAction(reactor: HistoryViewReactor) {
        rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output
    private func bindState(reactor: HistoryViewReactor) {
        reactor.state.map { $0.historyList }
            .map { [HistorySection(items: $0)] }
            .bind(to: historyTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    func bind() {
        historyTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        tableView.layoutMargins = .zero
    }
}
