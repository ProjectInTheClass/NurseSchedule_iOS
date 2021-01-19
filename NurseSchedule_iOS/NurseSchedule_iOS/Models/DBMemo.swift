//
//  DBMemo.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/19.
//

import Foundation
import Firebase

class DBMemo {
    let ref : DatabaseReference! = Database.database().reference()
    
    static let newMemo = DBMemo()
    
    
    func setMemo(userID : String, newMemo : NewMemo) {
        let reference  = ref.child("Schedule/\(userID)/\(newMemo.date)")

        let addMemo = ["workType" : newMemo.workType.workAt, "memo" : newMemo.memo]
        reference.setValue(addMemo)
        
        print("setMemo >>>>>\(addMemo)")
    }
    
    func getMemo(userID : String, date : String, completion: @escaping ([String]) -> Void){
        _ = ref.child("Schedule/\(userID)/\(date)").observe(.value, with: { snapshot in
            print(snapshot)
            if let value = snapshot.value as? NSDictionary {
                let el = value["memo"] as? String ?? "No Memo"
                let result = [el, el, el]//정의 받아오는 부분, 정의에 대한 변수]
                print("DBMemo read done >>> \(result)")
                completion(result)
            } else {
                completion([])
            }
        })
    }
}


