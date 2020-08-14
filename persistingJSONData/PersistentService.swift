
import Foundation
import CoreData

//MARK: - CoreData Stack

class PersistenceService {
    
        private init() {}
        static let shared = PersistenceService()
        
        
        var context: NSManagedObjectContext { return persistentContainer.viewContext }
        

    
    lazy var persistentContainer: NSPersistentContainer = {
    
           let container = NSPersistentContainer(name: "persistingJSONData")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {

                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()

       // MARK: - Core Data Saving support

    func save(completionHandler: @escaping () -> Void ) {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
                completionHandler()
                print("saved succesfully")
                NotificationCenter.default.post(name:
                    NSNotification.Name("Persisted data updated"), object: nil)
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    //fetch the object and save in coreData 
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        do {
            let objects = try context.fetch(request)
            completion(objects)
        } catch {
            print(error)
            completion([])
        }
       
    }
    


}
