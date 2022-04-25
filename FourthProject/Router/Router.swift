//
//  Router.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import UIKit

protocol RouterProtocol {
    func showDetailsViewController(article: Article)
    var navigationController: UINavigationController { get set }
    func pop()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    var assemblyBuilder: BuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func showDetailsViewController(article: Article) {
        guard let detailsVC = assemblyBuilder?.createDetailsVC(article: article) else { return }
        navigationController.pushViewController(detailsVC, animated: true)
    }
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
