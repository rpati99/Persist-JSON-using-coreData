
import Foundation
import CoreData

class DataStore: NSObject {
    let persistence = PersistenceService.shared
    let networking = NetworkingService.shared
    
    private override init() {
        super.init()
    }
    
    static let shared = DataStore()
    
    func request( completion: @escaping ([User]) -> Void) {
        //go out to the internet
        
        networking.request("https://kiloloco.com/api/users") { [weak self ] (result) in
            
            //get back some data
            switch result {
          case .success(let data):
              
              do {
                  guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: [])
                      as? [[String: Any]] else {return}
                  
                  jsonArray.forEach {
                      //compactMap scans the json object and returns an array of non optional value
                      guard
                          let strongSelf = self,
                          let name = $0["name"] as? String,
                          let age = $0["age"] as? Int16,
                          let id = $0["id"] as? Int16
                          else {return  }
                      
                      let user = User(context: strongSelf.persistence.context)
                      user.name = name
                      user.age = age
                      user.id = id
                  }

                  
                //save the data to coreData
                  DispatchQueue.main.async {
                            
                    self?.persistence.save {
                        self?.persistence.fetch(User.self, completion: { (objects) in
                            completion(objects)
                        })
                    }
                  }
                  
              } catch {
                  print(error)
              }
              
          case .failure(let error):
              print(error)

            }
            
        }
        
        
        //return the data from coreData
    }
    
}
