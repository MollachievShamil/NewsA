//
//  AssemblyBuilder.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createDetailsVC(article: Article) -> UIViewController 
    func createTabBar() -> UITabBarController
}

class ModuleBuilder: BuilderProtocol {
    private func createFirstVC() -> UIViewController {
        let view = FirstVC()
        let networkService = NetworkService()
        let navigationController = createNavigationViewController(controller: view,
                                                                  title: "All News",
                                                                  image: UIImage(systemName: "newspaper"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = FirstPresenter(view: view, network: networkService, router: router)
        view.presenter = presenter
        
        return navigationController
    }
    private func createFavoriteVC() -> UIViewController {
        let view = FavoriteVC()
        let networkService = NetworkService()
        let navigationController = createNavigationViewController(controller: view,
                                                                  title: "Favorite News",
                                                                  image: UIImage(systemName: "heart"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = FavoritePresenter(view: view, network: networkService, router: router)
        view.presenter = presenter
        return navigationController
    }
    
    func createProfileVC() -> UIViewController {
        let view = ProfileVC()
        let networkService = NetworkService()
        let presenter = ProfilePresenter(view: view, network: networkService)
        view.presenter = presenter
        return view
    }
    func createDetailsVC(article: Article) -> UIViewController {
        let view = DetailsVC()
        let networkService = NetworkService()
        let navigationController = createNavigationViewController(controller: view,
                                                                  title: "Favorite News",
                                                                  image: UIImage(systemName: "heart"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = DetailsPresenter(view: view, network: networkService, article: article, router: router)
        view.presenter = presenter
        return view
    }
    func createNavigationViewController(controller: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = title
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }
}

extension ModuleBuilder {
    func createTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        let firstVC = createFirstVC()
        let favoriteVC = createFavoriteVC()
        let profileVC = createProfileVC()
        tabBarController.viewControllers = [firstVC, favoriteVC, profileVC]
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.backgroundColor = .lightGray
        profileVC.title = "User Info"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        return tabBarController
    }
}
