//
//  ProfileModel+CoreDataProperties.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 21.04.2022.
//
//

import Foundation
import CoreData

extension ProfileModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileModel> {
        return NSFetchRequest<ProfileModel>(entityName: "ProfileModel")
    }

    @NSManaged public var usersName: String?
    @NSManaged public var dateOfUserBirth: String?
    @NSManaged public var usersGender: String?
    @NSManaged public var profileImage: Data?

}

extension ProfileModel : Identifiable {

}
