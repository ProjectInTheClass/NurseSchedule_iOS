//
//  DBDiary.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/19.
//

import Foundation
import Firebase

struct Diary{
    var date : Date
    var emoji : String
    var content : String
}

class DBDiary {
    let ref : DatabaseReference! = Database.database().reference()
    
    static let diary = DBDiary()
    
    func addDiary(date : Date, emoji : String, content: String) {
        let diaryInfo = [ "D_date" : date, "D_emoji" : emoji, "D_content" : content] as [String : Any]
        
        
        let refer = ref.child("Diary").childByAutoId() //데이터 목록에 새로 추가
        //childByAutoId()를 호출할때마다 고유한 키 값 생성
        
        refer.setValue(diaryInfo)
        
        
    }
    
    func getDiary(date date : String){
        //
        
    }
}

