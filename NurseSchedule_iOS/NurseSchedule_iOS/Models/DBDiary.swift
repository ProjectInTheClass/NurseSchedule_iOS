//
//  DBDiary.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/19.
//

import Foundation
import Firebase



class DBDiary {
    
 
    
    let ref : DatabaseReference! = Database.database().reference()
    
    static let newDiary = DBDiary()
    
    var diarycellCount : Int = 0

    func addDiary(userID: String, shortDate: String, new: Day){
        
        let reference = ref.child("Diary/\(userID)/\(shortDate)/\(new.date)") //데이터 목록에 추가
        
        let newDiary = ["D_emoji" : new.emoji , "D_content" : new.content , "D_date" : new.date]
        
        reference.setValue(newDiary)
        
        print("addDiary >>> \(newDiary)")
    }
    
    
    func getDiary(userID: String, shortDate : String, completion : @escaping (Day) -> Void) {
        ref.child("Diary/\(userID)/\(shortDate)").observeSingleEvent(of: .value, with: { snapshot in
            self.diarycellCount = Int(snapshot.childrenCount)
            print("snapshot.childrencount ->  \(snapshot.childrenCount)")
            guard let value = snapshot.value as? [String: Any] else{
                return
            }
         //   print("Value: \(value)")
            
           // print(snapshot)

            let enumerator = snapshot.children
                        while let rest = enumerator.nextObject() as? DataSnapshot {
                         
                           // print(rest.value)
                            var get = Day(emoji: "-", date: "-", content: "-")
                            if let result = (rest.value as AnyObject)["D_content"]! as? String
                            {
                             //    print(result)
                                get.content = result
                            }
                            if let result = (rest.value as AnyObject)["D_date"]! as? String
                            {
                             //   print(result)
                                get.date = result
                            }
                            if let result = (rest.value as AnyObject)["D_emoji"]! as? String
                            {
                             //   print(result)
                                get.emoji = result
                            }
                            
                            completion(get)
                          
                        }
    
          
            
            
            
            
          
//            for i in 1...snapshot.childrenCount {
//                ref.child("Diary/\(userID)/\(shortDate)")
//            }
            
        })
    }
    


    
 
}

