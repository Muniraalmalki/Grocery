//
//  CroceriesBuyViewController.swift
//  Grocery
//
//  Created by munira almallki on 05/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import CoreData

class ItemViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "grocery-items")
    var refObsers : [DatabaseHandle] = []
  
    let userRef = Database.database().reference(withPath: "online")
    var userrRefAbservers : [DatabaseHandle] = []
    
    var items : [Item] = []
    var user: User?
    var handle: AuthStateDidChangeListenerHandle?
    var userOnlineCount = 0
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
       fetchItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        ref.observeSingleEvent(of: .value, with: {snapshot in
//              print(snapshot.value as Any)
//          })
//             ref.observeSingleEvent(of: .value, with: {snapshot in
//                var newItem : [Item] = []
//              for child in snapshot.children{
//                  if let snapshot = child as? DataSnapshot ,
//                     let GroceryItem = Item(snapShot: snapshot){
//                      newItem.append(GroceryItem)
//
//                  }
//              }
//              self.items = newItem
//
//          self.tableView.reloadData()
//
//          })
        

    }
  @IBAction func addItem(_ sender: Any) {

      addItem()
}
 // add item func
    func addItem(){
       
              let alert = UIAlertController(title: "New Item",
                                                          message: "Add a new Item",
                                                     preferredStyle: .alert)
              alert.addTextField(configurationHandler: nil)

            
                            let saveAction = UIAlertAction(title: "Save", style: .default)
              {
                   _ in
                  let item = alert.textFields![0]
                 
                  let email = Auth.auth().currentUser?.email
                  let Groncey = ["addedByUser": email ,
                                 "completition":false  ,
                                 "name": item.text!]  as! [String: Any]
                  self.ref.child(item.text!).setValue(Groncey)
//                  self.ref.childByAutoId().setValue(Groncey)
                
                 
                 
              }
              
              
                   let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                     alert.addAction(saveAction)
                     alert.addAction(cancelAction)
                  self.present(alert, animated: true, completion: nil)

      }
    // fetch item
    func fetchItem (){
    
        ref.observe(.value, with: {snapshot in
               var newItem : [Item] = []
             for child in snapshot.children{
                 if let snapshot = child as? DataSnapshot {
                    let GroceryItem = Item(snapShot: snapshot)!
                    // print("----G---")
                    // print(GroceryItem)
                    // print("----G---")
                     newItem.append(GroceryItem)

                 }
             }
             self.items = newItem
               // print("-------")
              //  print(self.items)
             //   print("-------")
                 self.tableView.reloadData()
            
        })
    
    }
    // update item
    func updateItem(key : String){
        
   
      
           
            let alert = UIAlertController(title: "Update Item",
                                                        message: "Update Item",
                                                   preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)

          
                          let saveAction = UIAlertAction(title: "Save", style: .default)
            {
                 _ in
                
                let item = alert.textFields![0]
               
                let email = Auth.auth().currentUser?.email
                let Groncey = ["addedByUser": email ,
                               "completition":false  ,
                               "name": item.text!]  as! [String: Any]
                self.ref.child(key).setValue(Groncey)
              
     
            }
                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                   alert.addAction(saveAction)
                   alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
    }
    
   
    // delete item
    func delete(ref: DatabaseReference){
        
        ref.removeValue()
        
    }
           
    @IBAction func countOnlineItemBarButtion(_ sender: UIBarButtonItem) {
        let onlineVC = storyboard?.instantiateViewController(withIdentifier: "onlineVC") as! OnlineViewController
        onlineVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(onlineVC, animated: true)
    }
    }


    
extension ItemViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! cell
        let list = items[indexPath.row]
        cell.namelabel.text = list.name
        cell.emailLabel.text = list.addByUser
        
        //print(cell)
       
        return cell
    
}
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        print(self.items[indexPath.row])
        updateItem(key: self.items[indexPath.row].key)
    

        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let  itemDelete = items[indexPath.row]
            delete(ref: itemDelete.ref!)
        }
    }
     
}
