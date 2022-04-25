//
//  CoreDataManager.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 21.04.2022.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    static var shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfCoreDataCities: [CDNewsModel]?
    var profileInfo: [ProfileModel]?
  
    // MARK: - Profile section
    func saveProfileToCoreData(name: String, gender: String, dateOfBirth: String, imageData: Data) {
        var profile: ProfileModel?
        profile = profileInfo?.count == 0 ? ProfileModel(context: context) :  profileInfo![0]
        profile?.usersName = name
        profile?.usersGender = gender
        profile?.dateOfUserBirth = dateOfBirth
        profile?.profileImage = imageData
        save()
        fetchData()
    }
    
    func fetchDataForProfile() {
        do {
            profileInfo =  try context.fetch(ProfileModel.fetchRequest())
        } catch {
            print("error")
        }
    }
    // MARK: - News Section
    func createNewsCoreDataModel(title: String, description: String,
                                 author: String, publishedAt: String,
                                 newsURL: String, imageURL: String) -> CDNewsModel {
        let news = CDNewsModel(context: context)
        news.titleCD = title
        news.descriptionCD = description
        news.authorCD = author
        news.publishedAtCD = publishedAt
        news.newsURLCD = newsURL
        news.imageURLCD = imageURL
        return news
    }
    func saveToCoreData(model: CDNewsModel) {
        print(model)
        save()
        fetchData()
    }
    func deleteFromCoreData(ind: Int) {
        context.delete(arrayOfCoreDataCities![ind])
        print("deleted")
        save()
        fetchData()
    }
    func imageExistInCoreData(str: String) -> Bool {
        guard let arrayOfCoreDataCities = arrayOfCoreDataCities else { return false}
        for model in arrayOfCoreDataCities {
            if model.titleCD == str {
                return true
            }
        }
        return false
    }
    func fetchData() {
        do {
            arrayOfCoreDataCities =  try context.fetch(CDNewsModel.fetchRequest())
            print(arrayOfCoreDataCities?.count)
        } catch {
            print("error")
        }
    }
    func save() {
        do {
            try self.context.save()
            print("saved")
        } catch {
            print(error)
        }
    }
}
