//
//  NewsModel.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation

struct News: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var url: URL?
    var urlToImage: String?
    var publishedAt: Date?
}
