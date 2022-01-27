//
//  ViewController.swift
//  Grocery
//
//  Created by munira almallki on 05/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {
 
    let ref = Database.database().reference(withPath: "online")

    // Outlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
    }

    @IBAction func LoginButton(_ sender: UIButton) {
        guard let email = emailTextField.text , let password = passwordTextField.text else{
            return
        }

        // Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(email)")
                return
            }
            let user = result.user
            
            //----------------ONLINE-------
            let userData = ["user": email ]  as! [String: Any]
          
            self.ref.child(user.uid).setValue(userData)
            print("logged in user: \(user)")
        })

        let GroceriesBuyVC = storyboard?.instantiateViewController(withIdentifier: "GroceriesBuyVC") as! ItemViewController
        GroceriesBuyVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(GroceriesBuyVC, animated: true)
        
        
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        

                guard let email = emailTextField.text , let password = passwordTextField.text else{
                    return
                }
                // Firebase Login / check to see if email is taken
                // try to create an account
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult , error  in
                    guard let result = authResult, error == nil else {
                        print("Error creating user")
                        return
                    }
                    let user = result.user
                    print("Created User: \(user)")
                })
        
                let GroceriesBuyVC = storyboard?.instantiateViewController(withIdentifier: "GroceriesBuyVC") as! ItemViewController
                GroceriesBuyVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(GroceriesBuyVC, animated: true)
        

       }

     }
