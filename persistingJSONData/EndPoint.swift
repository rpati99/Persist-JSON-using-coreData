//endpoint

import Foundation
import CoreData

enum EndPoint<T: NSManagedObject> {
    
     case users
    
    var urlPath: String {
        switch self {
        case.users : return "https://kilolico.com/api/users"
        }
    }
}
