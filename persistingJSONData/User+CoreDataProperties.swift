

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String //thats mandatory and not optional
    @NSManaged public var age: Int16
    @NSManaged public var id: Int16

}
