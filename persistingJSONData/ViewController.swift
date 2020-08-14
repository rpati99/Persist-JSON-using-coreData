

import UIKit
import CoreData

class ViewController: UITableViewController {
    let store = DataStore.shared
    
    var users = [User]()  //an empty array of type User 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        store.request() { [weak self] (users) in
            self?.users = users
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name + " is " + "\(user.age)" + " years old "
        cell.detailTextLabel?.text = String(user.id)
        return cell
    }
    
    
}

