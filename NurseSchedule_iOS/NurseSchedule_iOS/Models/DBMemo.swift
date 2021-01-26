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
    
    func addDaySchedule(newDay : ForSavingDayWorkNMemo) {
        let reference = ref.child("Schedule/\(currentUser)/\(newDay.date)/")
        let newMemo = ["date": newDay.date, "memo": newDay.memo, "workType": newDay.worktype]
        reference.setValue(newMemo)
    }
    
    func getDaySchedule(date : String, completion : @escaping (ForSavingDayWorkNMemo) -> Void ) {
        ref.child("Schedule/\(currentUser)/\(date)").observeSingleEvent(of: .value) { (snapshot) in
            var daySchedule : ForSavingDayWorkNMemo = ForSavingDayWorkNMemo(date: date, worktype: "", memo: "")
            if let value = snapshot.value as? NSDictionary {
                daySchedule.date = value["date"] as? String ?? "date_error"
                daySchedule.worktype = value["workType"] as? String ?? "workType_error"
                daySchedule.memo = value["memo"] as? String ?? "memo_error"
                print("getDaySchedule >>>> \(value)")
                completion(daySchedule)
            } else {
                print("getDaySchedule >>>> no Memo")
                completion(daySchedule)
            }
        }
    }
    
    func getWorkType(completion : @escaping (ForSavingDayWorkNMemo) -> Void) {
        ref.child("Schedule/\(currentUser)/").observeSingleEvent(of : .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                var gettype = ForSavingDayWorkNMemo(date: "getWorkTypeDate", worktype: "", memo: "")
                if let dateResult = (rest.value as AnyObject)["date"]! as? String {
                    print(dateResult)
                    gettype.date = dateResult
                }
                if let workTypeResult = (rest.value as AnyObject)["workType"]! as? String {
                    print(workTypeResult)
                    gettype.worktype = workTypeResult
                }
                if let memoresult = (rest.value as AnyObject)["date"]! as? String {
                    print(memoresult)
                    gettype.memo = memoresult
                }
                completion(gettype)
            }
        })
    }
    
    //    func getWorkType(userID : String, completion: @escaping (NewMemo)-> Void){
    //        _ = ref.child("Schedule/\(userID)/").observe(.value,with: { snapshot in
    //            let enumerator = snapshot.children
    //            while let rest = enumerator.nextObject() as? DataSnapshot {
    //                //print(rest.value)
    //                //let result = rest.value["date"] as? String
    //                var gettype = NewMemo(date: "getWorktypeDate", workType: .OFF, memo: "")
    //                if let dateresult = (rest.value as AnyObject)["date"]! as? String
    //                {
    //                   print(dateresult)
    //                    gettype.date = dateresult
    //                }
    //                if let worktyperesult = (rest.value as AnyObject)["workType"]! as? String
    //                {
    //                   print(worktyperesult)
    //                    switch worktyperesult {
    //                    case "DAY":
    //                        gettype.workType = .DAY
    //                    case "EVENING":
    //                        gettype.workType = .EVENING
    //                    case "NIGHT":
    //                        gettype.workType = .NIGHT
    //                    case "OFF":
    //                        gettype.workType = .OFF
    //                    default:
    //                        gettype.workType = .OFF
    //                    }
    //                }
    //                completion(gettype)
    //            }
    //        })
    //    }
    
    
    //    func setMemo(userID : String, newMemo : NewMemo) {
    //        getMemo(userID: userID, date: newMemo.date) { (currentMemo) in
    //            //            self.memoList.append(contentsOf: currentMemo)
    //            let reference  = self.ref.child("Schedule/\(userID)/\(newMemo.date)")
    //            let memoList = currentMemo + [newMemo.memo]
    //            let addmemo = ["date" : newMemo.date, "workType" : newMemo.workType.workAt, "memoList" : memoList] as [String : Any]
    //            reference.setValue(addmemo)
    //            print("setMemo >>>>>\(addmemo)")
    //        }
    //    }
    //
    //    func getMemo(userID : String, date : String, completion: @escaping ([String]) -> Void){
    //        ref.child("Schedule/\(userID)/\(date)/").observeSingleEvent(of:.value, with: { snapshot in
    //            if let value = snapshot.value as? NSDictionary {
    //                let result = value["memoList"] as? [String] ?? []
    //            print("DBMemo getMemo >>> \(result)")
    //                completion(result)
    //            } else {
    //                completion([])
    //            }
    //        })
    //    }
    //
    //    func deleteMemo(date : String, index: Int) {
    //        ref.child("Schedule/\(currentUser)/\(date)/memoList/\(index)").removeValue()
    //    }
    //
    
    
    
    
    //
    //
    //
    //    func setWorkType(userID : String, newMemo : NewMemo) {
    //        let type = [newMemo.date : newMemo.workType]
    //        let reference = ref.child("workTypewithDate/\(userID)/workTypes")
    //        reference.setValue(type)
    //    }
    //
    //    func getWorkType(userID : String, completion: @escaping ([String : WorkType])-> Void){
    //        ref.child("workTypewithDate/\(userID)/").observeSingleEvent(of: .value, with: {
    //            snapshot in
    //            if let value = snapshot.value as? NSDictionary {
    //                let result = value["workTypes"] as? [String : WorkType] ?? [:]
    //                print("DBMemo getWorkType >>> \(result)")
    //                completion(result)
    //            } else {
    //                completion([:])
    //            }
    //        })
    //    }
    
    
    //    func getWorkType(userID : String, completion: @escaping (WorkType) -> Void ) {
    //        ref.child("Schedule/\(userID)/").observe(.value, with: { snapshot in
    //            if let findedDate = snapshot.value as? String{
    //                print("겟월크 날짜 있냐!!!!!!!!!!!!!\(findedDate)")
    //                if let date = findedDate {
    //                    self.ref.child("Schedule/\(userID)/\(date)").observeSingleEvent(of: .value) { (snapshot) in
    //                        if let value = snapshot.value as? NSDictionary {
    //                            let result = value["workType"] as? WorkType ?? .OFF
    //                            print("DBMemo getWorkType >>> \(date)'s \(result)")
    //                            completion(result)
    //                        } else {
    //                            print("DBMemo getWorkType >>> no data")
    //                            completion(.OFF)
    //                        }
    //                    }
    //
    //                }
    //            }
    //        })
    //    }
    
    
    
}


