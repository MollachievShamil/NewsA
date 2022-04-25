//
//  DetailVCPresenter.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

protocol DetailsViewProtocol: AnyObject {
}

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol,  network: NetworkServiceProtocol,
         article: Article, router: RouterProtocol)
    func getImage(compl: @escaping ((UIImage)?) -> Void)
    func getStringsFromArticleModel(labels: (String, String, String, String, String, String) -> Void)
    func saveButtonTapped()
    func isNewsExistInCoreData() -> Bool
}

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    let network: NetworkServiceProtocol?
    var article: Article?
    var router: RouterProtocol?
    var model: CDNewsModel?
    
    // MARK: - Init
    required init(view: DetailsViewProtocol, network: NetworkServiceProtocol,
                  article: Article, router: RouterProtocol) {
        self.view = view
        self.network = network
        self.article = article
        self.router = router
        print(article)
    }
    func transformJSONModelToCoredataModel() -> CDNewsModel {
        var newsModelForCoreData = CDNewsModel()
        getStringsFromArticleModel { textForTitle, textForAuthor, textForDescription, dateOfPublic, source, imageURL in
            newsModelForCoreData = CoreDataManager.shared.createNewsCoreDataModel(title: textForTitle, description: textForDescription, author: textForAuthor, publishedAt: dateOfPublic, newsURL: source, imageURL: imageURL)
        }
        return newsModelForCoreData
    }
    func getImage(compl: @escaping ((UIImage)?) -> Void) {
        guard let urlExist = article?.urlToImage  else { print("no url"); return}
        network?.getImage(urlString: urlExist) { image in
            compl(image)
        }
    }
    func getStringsFromArticleModel(labels: (String, String, String, String, String, String) -> Void) {
        let titleText = article?.title ?? " No Title"
        let author = article?.author ?? "No Author"
        let description = article?.description ?? "No Description"
        let newsURLJSONModel = article?.url ?? URL(string: "No basic News URL")
        let transformedURLToString = newsURLJSONModel!.absoluteString
        let imageURLJSONModel = article?.urlToImage ??
        "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd, hh:mm"
        let dateOfPublish = dateFormatter.string(from: (article?.publishedAt)!)
        labels(titleText, author, description, dateOfPublish, transformedURLToString, imageURLJSONModel)
    }
    func saveButtonTapped() {
        CoreDataManager.shared.saveToCoreData(model: transformJSONModelToCoredataModel())
    }
    func isNewsExistInCoreData() -> Bool {
        return CoreDataManager.shared.imageExistInCoreData(str: (article?.title)!)
    }
}
