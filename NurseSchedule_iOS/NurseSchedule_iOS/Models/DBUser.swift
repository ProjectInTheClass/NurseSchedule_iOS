//
//  DBTest.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import Foundation
import Firebase

struct Users {
    //childByAutoId()
    //let serialNum : String
    let name : String
    let email : String
}


class DBUser {
    let ref : DatabaseReference! = Database.database().reference()
    
    static let users = DBUser()
    
    
    func setUser(userName : String, userEmail : String) -> String {
        let userInfo = ["name" : userName, "email" : userEmail]

        let reference  = ref.child("Users").childByAutoId()

        reference.setValue(userInfo)
        
        let childautoID = reference.key
        print("childautoID: \(childautoID)")
        return childautoID ?? "fail"
    }
    
    func getUser(_ user_serialNum : String){
        _ = ref.child("Users/"+user_serialNum).observe(.value, with: { snapshot in
            print(snapshot)
            print("snapshot.key : \(snapshot.key)") //serialNum
            print("snapshot.value : \(snapshot.value)")
        })
    }
}

