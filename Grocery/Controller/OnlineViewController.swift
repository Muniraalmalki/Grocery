//
//  OnlineViewController.swift
//  Grocery
//
//  Created by munira almallki on 05/04/1443 AH.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseDatabase
class OnlineViewController: UIViewController {
    var users = [String] ()
    let ref = Database.database().reference(withPath: "online")
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         
        tableView.dataSource = self
        tableView.delegate = self
        fetchUsers()
    }
    
   
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        guard let user = Auth.auth().currentUser else { return }
        let onlineRef = Database.database().reference(withPath: "online/" + user.uid)
        // 2
        onlineRef.removeValue { error, _ in
          // 3
          if let error = error {
            print("Removing online failed: \(error)")
            return
          }
          // 4
          do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
          } catch let error {
            print("Auth sign out failed: \(error)")
          }
        }
    }
    
    func fetchUsers (){
       
        self.ref.observe(.value, with:
            {snapshot in
               var newUesrs : [String] = []
             for child in snapshot.children{
                 if let snapshot = child as? DataSnapshot {
                    
                    
                     guard let value = snapshot.value as? [String: Any],
                    let userEmail = value["user"] as? String
                     else{
                       //  print("Error")
                        // print(snapshot.value)
                         return
                     }
                     
                     newUesrs.append(userEmail)

                 }
             }
             self.users = newUesrs
          //  print("USERS")
           // print(self.users)
             self.tableView.reloadData()
            
        })
        
    }
}
extension OnlineViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell2
        
        cell.emailLabel.text = users[indexPath.row]
        return cell
    }
    
    
    
    
}
