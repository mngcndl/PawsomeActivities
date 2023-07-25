import Foundation
import CoreData
import UIKit


extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog")
    }
    
    @NSManaged public var message: String?
    @NSManaged public var status: String?
}

extension Dog : Identifiable {

}
