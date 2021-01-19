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
        
        getMemo(userID: userID, date: newMemo.date) { (currentMemo) in
//            self.memoList.append(contentsOf: currentMemo)
            let reference  = self.ref.child("Schedule/\(userID)/\(newMemo.date)")
            let memoList = currentMemo + [newMemo.memo]
            let addmemo = ["workType" : newMemo.workType.workAt, "memoList" : memoList] as [String : Any]
            reference.setValue(addmemo)
            print("setMemo >>>>>\(addmemo)")
        }

    }
    
    func getMemo(userID : String, date : String, completion: @escaping ([String]) -> Void){
        ref.child("Schedule/\(userID)/\(date)/").observeSingleEvent(of:.value, with: { snapshot in
            if let value = snapshot.value as? NSDictionary {
                let result = value["memoList"] as? [String] ?? []//정의 받아오는 부분, 정의에 대한 변수]
                print("DBMemo getMemo >>> \(result)")
                completion(result)
            } else {
                completion([])
            }
        })
    }
    
    func getWorkType(userID : String, date:String, completion: @escaping (String) -> Void ) {
        ref.child("Schedule/\(userID)/\(date)/").observeSingleEvent(of:.value, with: { snapshot in
            if let value = snapshot.value as? NSDictionary {
                let result = value["workType"] as? String ?? ""//정의 받아오는 부분, 정의에 대한 변수]
                print("DBMemo getWorkType >>> \(result)")
                completion(result)
            } else {
                completion("")
            }
        })
    }
}


