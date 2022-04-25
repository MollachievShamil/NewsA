//
//  FirstVC.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

class FirstVC: UIViewController {
    var presenter: FirstPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViews()
        setupConstraints()
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
extension FirstVC {
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
extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.arrayOfArticles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.arrayOfArticles[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.returnArticle(ind: indexPath.row)
        presenter.goToDetailsVC(article: article)
    }
}

extension FirstVC: FirstViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
