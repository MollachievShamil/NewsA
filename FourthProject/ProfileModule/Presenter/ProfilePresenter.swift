//
//  ProfilePresenter.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, network: NetworkServiceProtocol)
    func getInfoForLabels(labels: (String, String, String, UIImage) -> Void)
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    let network: NetworkServiceProtocol?
    // MARK: - Init
    required init(view: ProfileViewProtocol, network: NetworkServiceProtocol) {
        self.view = view
        self.network = network
    }
    // UNRAP
    func getInfoForLabels(labels: (String, String, String, UIImage) -> Void) {
        CoreDataManager.shared.fetchDataForProfile()
        if CoreDataManager.shared.profileInfo?.count == 0 {
        } else {
            guard let profile = CoreDataManager.shared.profileInfo?[0] else {return}
            let name = profile.usersName ?? "No name"
            let dateOfBirth = profile.dateOfUserBirth ?? "00.00.0000"
            let gender = profile.usersGender ?? "No Gender"
            let imageDate = profile.profileImage!
            let image = UIImage(data: imageDate) ?? UIImage()
            labels(name, dateOfBirth, gender, image)
        }}
}
