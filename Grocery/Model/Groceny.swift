//
//  extension.swift
//  Grocery
//
//  Created by munira almallki on 05/04/1443 AH.
//

import Foundation
import Firebase
import FirebaseDatabase

import CoreData

struct Item {

    let ref : DatabaseReference?

    let addByUser :String
     let completion: Bool
    let name: String
    let key: String
    init(addByUser: String , completion: Bool , name: String , key: String )
    {
        self.ref = nil
        self.key = key
        self.addByUser = addByUser
        self.completion = completion
        self.name = name

    }


    init?(snapShot: DataSnapshot){
      //  print("----1---")
     //   print(snapShot.value as Any)
     //   print("----1---")
        guard let value = snapShot.value as? [String: Any],
        let addByUser = value["addedByUser"] as? String,
        let completion = value["completition"] as? Bool ,
        let name = value["name"] as? String
        else{

            return nil
        }
        self.ref = snapShot.ref
        self.key = snapShot.key
        self.addByUser = addByUser
        self.completion = completion
        self.name = name
        print(addByUser)
      }

    func toAnyObject () -> [String:Any]{
        return [
            "addByUser": addByUser ,
            "completition": completion,
            "name": name
               ]


    }

}

struct User{
    let uid : String
    let email: String
    init(authData : Firebase.User){
        uid = authData.uid
        email = authData.email ?? ""
    }
    init(uid: String , email: String){
        self.uid = uid
        self.email = email
    }
}

