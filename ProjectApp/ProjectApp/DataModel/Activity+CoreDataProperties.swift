import Foundation
import CoreData
import UIKit


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }
    
    @NSManaged public var activity: String?
    @NSManaged public var type: String?
    @NSManaged public var link: String?
    @NSManaged public var participants: Int64
    @NSManaged public var key: Int64
    @NSManaged public var accessibility: Double
    @NSManaged public var price: Double
}

extension Activity : Identifiable {

}
