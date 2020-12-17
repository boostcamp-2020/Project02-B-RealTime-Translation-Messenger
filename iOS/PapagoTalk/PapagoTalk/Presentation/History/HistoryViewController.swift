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
    
    private let alertFactory: AlertFactoryProviding
    private let datasource = HistoryDatasource()
    var disposeBag = DisposeBag()
    weak var coordinator: HomeCoordinating?
    
    init?(coder: NSCoder, reactor: HistoryViewReactor, alertFactory: AlertFactoryProviding) {
        self.alertFactory = alertFactory
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        self.alertFactory = AlertFactory()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.systemGray6
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: "NavigationBarColor")
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
        
        NotificationCenter.default.rx.notification(.reEnterButtonDidTap)
            .asObservable()
            .compactMap { $0.userInfo?["code"] as? String }
            .map { Reactor.Action.reEnterButtonTapped($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output
    private func bindState(reactor: HistoryViewReactor) {
        reactor.state.map { $0.historyList }
            .map { [HistorySection(items: $0)] }
            .bind(to: historyTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.chatRoomInfo }
            .distinctUntilChanged()
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] roomInfo in
                self?.navigationController?.popViewController(animated: false)
                self?.coordinator?.pushChat(roomID: roomInfo.roomID, code: roomInfo.code)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.errorMessage }
            .distinctUntilChanged()
            .compactMap { $0.data }
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                self?.alert(message: $0)
            })
            .disposed(by: disposeBag)
    }
    
    func bind() {
        historyTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func alert(message: String) {
        present(alertFactory.alert(message: message), animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        tableView.layoutMargins = .zero
    }
}
