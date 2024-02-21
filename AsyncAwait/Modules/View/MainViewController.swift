//
//  MainViewController.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeConstraints()
        configureDelegate()
        viewModel?.viewDidLoadTask()
    }
}

private
extension MainViewController {
    func makeConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    func configureDelegate() {
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.tabListSection.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel?.tabListSection[section] {
        case .apps:
            return 1
        case .books:
            return 1
        case .podcasts:
            return 1
        case .songs:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel?.tabListSection[indexPath.section] {
        case .songs:
            return UITableViewCell()
        case .books:
            return UITableViewCell()
        case .podcasts:
            return UITableViewCell()
        case .apps:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func handle(_ notify: MainViewNotify) {
        switch notify {
        case .didFetchSongs:
            break
        case .didFetchApps:
            break
        case .didFetchBooks:
            break
        case .didFetchPodcasts:
            break
        case .reloadTableView:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
