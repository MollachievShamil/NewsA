//
//  DetailsVC.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

class DetailsVC: UIViewController {
    var presenter: DetailsPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setLabels()
        setupViews()
        setConstraints()
        getImage()
        getInfoFromLabels()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButton()
    }
    func getImage() {
        presenter.getImage() { [weak self] image in
            self?.imageView.image = image ?? UIImage(systemName: "trash")
        }
    }
    func getInfoFromLabels() {
        presenter.getStringsFromArticleModel { textForTitle, textForAuthor, textForDescription, dateofPublic, source, imageURL in
            newsTitle.text = textForTitle
            descriptionLabel.text = textForDescription
            authorLabel.text = textForAuthor
            dateOfPublicationLabel.text = dateofPublic
            sourceOfNews.text = source
        }
    }
    func setButton() {
        if presenter.isNewsExistInCoreData() {
            addToFavoriteButton.backgroundColor = .white
            addToFavoriteButton.isUserInteractionEnabled = false
        } else {
            addToFavoriteButton.isUserInteractionEnabled = true
            addToFavoriteButton.backgroundColor = .orange
            addToFavoriteButton.setTitle("Add", for: .normal)
        }
    }
    var sourceOfNews = UILabel()
    var dateOfPublicationLabel = UILabel()
    var newsTitle = UILabel()
    var descriptionLabel = UILabel()
    var authorLabel = UILabel()
    func makeNewLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func setLabels() {
        newsTitle = makeNewLabel()
        descriptionLabel = makeNewLabel()
        authorLabel = makeNewLabel()
        dateOfPublicationLabel = makeNewLabel()
        sourceOfNews = makeNewLabel()
    }
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.setTitle("Dfdf", for: .normal)
        return button
    }()
    @objc func addToFavorite() {
        presenter.saveButtonTapped()
        setButton()
    }
}
// MARK: - Setting up Views
extension DetailsVC {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(newsTitle)
        view.addSubview(descriptionLabel)
        view.addSubview(authorLabel)
        view.addSubview(imageView)
        view.addSubview(dateOfPublicationLabel)
        view.addSubview(sourceOfNews)
        view.addSubview(addToFavoriteButton)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            newsTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            newsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newsTitle.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: dateOfPublicationLabel.topAnchor, constant: -10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authorLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            dateOfPublicationLabel.bottomAnchor.constraint(equalTo: sourceOfNews.topAnchor, constant: -10),
            dateOfPublicationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateOfPublicationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateOfPublicationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            sourceOfNews.bottomAnchor.constraint(equalTo: addToFavoriteButton.topAnchor, constant: -10),
            sourceOfNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sourceOfNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sourceOfNews.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            addToFavoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addToFavoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToFavoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
extension DetailsVC: DetailsViewProtocol {
}
