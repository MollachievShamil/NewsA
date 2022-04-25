//
//  FavoriteVCPresenter.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

protocol FavoriteViewProtocol: AnyObject {
}

protocol FavoritePresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol,  network: NetworkServiceProtocol, router: RouterProtocol)
    func goToDetailsVC(model: CDNewsModel)
}

class FavoritePresenter: FavoritePresenterProtocol {
    weak var view: FavoriteViewProtocol?
    let network: NetworkServiceProtocol?
    let router: RouterProtocol?
    
    // MARK: - Init
    required init(view: FavoriteViewProtocol, network: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.network = network
        self.router = router
        CoreDataManager.shared.fetchData()
    }
    
    func transformCoreDataModelToNewsModel(model: CDNewsModel) -> Article {
        let url = URL(string: model.newsURLCD!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd, hh:mm"
        let date = dateFormatter.date(from: model.publishedAtCD!)
        let art = Article(author: model.authorCD, title: model.titleCD, description: model.descriptionCD,
                          content: "nil", url: url, urlToImage: model.imageURLCD, publishedAt: date)
        return art
    }
    func goToDetailsVC(model: CDNewsModel) {
        let article = transformCoreDataModelToNewsModel(model: model)
        router?.showDetailsViewController(article: article)
    }
}
