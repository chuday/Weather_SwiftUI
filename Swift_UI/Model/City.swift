//
//  City.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 11.12.2021.
//

//import Foundation

//struct City: Identifiable {
//    let name: String
//    var id: String { name }
//}


import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var imageName: String
    
    @nonobjc public class func create(in context: NSManagedObjectContext, name: String, imageName: String?) throws {
        let city = City(context: context)
        city.name = name
        city.id = UUID()
        city.imageName = imageName ?? "default"
        try context.save()
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
}
