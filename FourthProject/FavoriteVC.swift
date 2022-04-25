//
//  FavoriteVC.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

class FavoriteVC: UIViewController {
    var presenter: FavoritePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupDelegates()
        setupViews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

// MARK: - Setting up Views
extension FavoriteVC {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView Delegates
extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.arrayOfCoreDataCities?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = CoreDataManager.shared.arrayOfCoreDataCities?[indexPath.row].titleCD ?? "No title"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = CoreDataManager.shared.arrayOfCoreDataCities?[indexPath.row] else {return}
        presenter.goToDetailsVC(model: model )
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            CoreDataManager.shared.deleteFromCoreData(ind: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
extension FavoriteVC: FavoriteViewProtocol {
}
