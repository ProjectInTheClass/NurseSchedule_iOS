//
//  DBDiary.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/21.
//

import Foundation
import Firebase



class DBDiary {
    let ref : DatabaseReference! = Database.database().reference()
    
    static let newDiary = DBDiary()
    
    func addDiary(userID: String, shortDate: String, new: Day){
        let reference = ref.child("Diary/\(userID)/\(shortDate)/\(new.date)") //데이터 목록에 추가
        let newDiary = ["D_emoji" : new.emoji , "D_content" : new.content , "D_date" : new.date]
        reference.setValue(newDiary)
        print("addDiary >>> \(newDiary)")
    }
    
    
    func getDiary(userID: String, shortDate : String, completion : @escaping (Day) -> Void) {
        ref.child("Diary/\(userID)/\(shortDate)").observeSingleEvent(of: .value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                // print(rest.value)
                var get = Day(emoji: "-", date: "-", content: "-")
                if let result = (rest.value as AnyObject)["D_content"]! as? String {
                    //    print(result)
                    get.content = result
                }
                if let result = (rest.value as AnyObject)["D_date"]! as? String {
                    //   print(result)
                    get.date = result
                }
                if let result = (rest.value as AnyObject)["D_emoji"]! as? String {
                    //   print(result)
                    get.emoji = result
                }
                completion(get)
                
            }
        })
    }
    
    
    
    func getDayDiary(userID : String, date : Date, completion : @escaping (Day?) -> Void) {
        let dateFormatter : DateFormatter = DateFormatter()
        //DB에 들어갈 날짜용 0(월단위)
        dateFormatter.dateFormat = "yyyy-MM"
        let dayMonth = dateFormatter.string(from: date)
        print("getDayDiary>> \(dayMonth)")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let day = dateFormatter.string(from: date)
        print("getDayDiary>> \(day)")
        ref.child("Diary/\(userID)/\(dayMonth)/\(day)/").observeSingleEvent(of: .value) { (snapshot) in
            var dayDiary : Day = Day(emoji: "", date: "", content: "")
            if let value = snapshot.value as? NSDictionary {
                dayDiary.emoji = value["D_emoji"] as? String ?? "D_emoji_error"
                dayDiary.date = value["D_date"] as? String ?? "D_date_error"
                dayDiary.content = value["D_content"] as? String ?? "D_content_error"
                print("DBgetDayDiary >>>>> \(dayDiary)")
                completion(dayDiary)
            } else {
                completion(nil)
            }
            
        }
    }
    
    
    //다이어리 삭제 함수
    func deleteDiary(userID : String, shortDate : String ,date: String){

        ref.child("Diary/\(userID)/\(shortDate)/\(date)").removeValue(completionBlock: {(err, ref) in
            if err != nil{
                debugPrint("fail")
                return
            }
        })
    }
    
    //다이어리 수정 함수
    func modifyDiary(userID: String, shortDate: String, new: Day){
        let reference = ref.child("Diary/\(userID)/\(shortDate)/\(new.date)")
        let changeDiary = ["D_emoji" : new.emoji , "D_content" : new.content , "D_date" : new.date]
        reference.setValue(changeDiary)
        print("modifyDiary >>> \(changeDiary)")
    }
}


