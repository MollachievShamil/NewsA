//
//  CDNewsModel+CoreDataProperties.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 21.04.2022.
//
//

import Foundation
import CoreData


extension CDNewsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNewsModel> {
        return NSFetchRequest<CDNewsModel>(entityName: "CDNewsModel")
    }

    @NSManaged public var authorCD: String?
    @NSManaged public var titleCD: String?
    @NSManaged public var descriptionCD: String?
    @NSManaged public var imageURLCD: String?
    @NSManaged public var publishedAtCD: String?
    @NSManaged public var newsURLCD: String?

}

extension CDNewsModel : Identifiable {

}
