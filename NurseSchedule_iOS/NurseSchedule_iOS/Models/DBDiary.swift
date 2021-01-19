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
    
    func addDiary(userID : String, newDiary : Day ) {
        let reference = ref.child("Diary/ \(userID) / \(newDiary.date)") //데이터 목록에 새로 추가
        //childByAutoId()를 호출할때마다 고유한 키 값 생성
        
        let new = [ "D_emoji" : newDiary.emoji, "D_content":newDiary.content]
        
        reference.setValue(new)
        
        print("addDiary >>>> \(new)")
        
    }
    
    func getDiary(userID : String, date :String) -> Void{
        _ = ref.child("Diary/\(userID)/\(date)").observe(.value, with: { snapshot in
           
            var diaryinfo = Day(emoji: "Emoji", date: "Date", content: "content")
            
            if let value = snapshot.value as? NSDictionary {
                diaryinfo.emoji = value["D_emoji"] as? String ?? " "
                diaryinfo.content =  value["D_content"] as? String ?? " "
                
                
                
            }
        })
        
        
    }

    
 
}

