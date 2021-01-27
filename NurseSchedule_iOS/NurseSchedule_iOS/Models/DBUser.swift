//
//  DBTest.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import Foundation
import Firebase

class DBUser {
    let ref : DatabaseReference! = Database.database().reference()
    
    static let users = DBUser()
    
    
    func setUser(userID : String) {
        //var userExist = userID
        ref.child("Users/\(userID)").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value == nil {
                let userInfo = ["userID" : userID]
                let reference  = self.ref.child("Users/\(userID)/")
                reference.setValue(userInfo)
            }
                
        }
        
//        let childautoID = reference.key
//        print("childautoID: \(childautoID)")
//        return childautoID ?? "fail"
    }
    
    func getUser(_ user_serialNum : String){
        _ = ref.child("Users/"+user_serialNum).observe(.value, with: { snapshot in
            print(snapshot)
            print("snapshot.key : \(snapshot.key)") //serialNum
            print("snapshot.value : \(snapshot.value)")
        })
    }
}

