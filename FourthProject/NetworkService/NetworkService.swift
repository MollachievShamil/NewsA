//
//  NetworkService.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getTopHeadlines(completion: @escaping ([Article]?) -> Void)
    func getImage(urlString: String, complition: @escaping ((UIImage)?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=6870c4cfbd7c461a9d5231d66e51789c"
    func getTopHeadlines(completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let news = try decoder.decode(News.self, from: data)
                completion((news.articles))
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    func getImage(urlString: String, complition: @escaping ((UIImage)?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    complition(nil)
                    print(error)
                }
                guard let data = data else { return }
                complition(UIImage(data: data))
            }
        }
        .resume()
    }
}
