//
//  FirstVCPresenter.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

protocol FirstViewProtocol: AnyObject {
    func reloadTableView()
}

protocol FirstPresenterProtocol: AnyObject {
    init(view: FirstViewProtocol,  network: NetworkServiceProtocol, router: RouterProtocol)
    var arrayOfArticles: [Article] {get set}
    func goToDetailsVC(article: Article)
    func returnArticle(ind: Int) -> Article
}

class FirstPresenter: FirstPresenterProtocol {
    
    weak var view: FirstViewProtocol?
    let network: NetworkServiceProtocol?
    var router: RouterProtocol?
    var arrayOfArticles: [Article] = []
    // MARK: - Init
    required init(view: FirstViewProtocol, network: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.network = network
        self.router = router
        getData()
    }
    func getData() {
        network?.getTopHeadlines(completion: { [weak self] articles in
            self?.arrayOfArticles = articles ?? []
            DispatchQueue.main.async {
                self?.view?.reloadTableView()
            }
        })
    }
    func returnArticle(ind: Int) -> Article {
        return arrayOfArticles[ind]
    }
    func goToDetailsVC(article: Article) {
        router?.showDetailsViewController(article: article)
    }
}
