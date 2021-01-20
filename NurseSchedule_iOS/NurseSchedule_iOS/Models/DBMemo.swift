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
            let addmemo = ["workType" : newMemo.workType, "memoList" : memoList] as [String : Any]
            reference.setValue(addmemo)
            print("setMemo >>>>>\(addmemo)")
        }
        
    }
    
    func getMemo(userID : String, date : String, completion: @escaping ([String]) -> Void){
        ref.child("Schedule/\(userID)/\(date)/").observeSingleEvent(of:.value, with: { snapshot in
            if let value = snapshot.value as? NSDictionary {
                let result = value["memoList"] as? [String] ?? []
                print("DBMemo getMemo >>> \(result)")
                completion(result)
            } else {
                completion([])
            }
        })
    }
    
    func getWorkType(userID : String, completion: @escaping (WorkType) -> Void ) {
        ref.child("Schedule/\(userID)/").observe(.value, with: { snapshot in
            if let findedDate = snapshot.value as? String
            
            print("겟월크 날짜 있냐!!!!!!!!!!!!!\(findedDate)")
            if let date = findedDate {
                self.ref.child("Schedule/\(userID)/\(date)").observeSingleEvent(of: .value) { (snapshot) in
                    if let value = snapshot.value as? NSDictionary {
                        let result = value["workType"] as? WorkType ?? .OFF
                        print("DBMemo getWorkType >>> \(date)'s \(result)")
                        completion(result)
                    } else {
                        print("DBMemo getWorkType >>> no data")
                        completion(.OFF)
                    }
                }
                
            }
        })
    }
    
    
    
}


