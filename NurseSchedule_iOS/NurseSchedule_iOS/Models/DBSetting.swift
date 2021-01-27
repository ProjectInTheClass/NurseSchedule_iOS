//
//  DBSetting.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/27.
//

import Foundation
import Firebase

struct MyArticle {
    var BoardType : String
    var serialNum : String
    var title : String
    var date : String
}

class DBSetting {
    
    static let setting = DBSetting()
    let ref : DatabaseReference! = Database.database().reference()
    
    
    //
    func getMyArticleList(completion : @escaping (myContentInfo) -> Void){
        ref.child("Users/\(currentUser!)/writtenContent").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("DBSetting in‼️‼️‼️‼️‼️‼️")
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                var myContent = myContentInfo(boardType: "", articleNum : "", title: "", date: "")
                if let result = (rest.value as AnyObject)["boardType"]! as? String {
                    myContent.boardType = result
                }
                if let result = (rest.value as AnyObject)["date"]! as? String {
                    myContent.date = result
                }
                if let result = (rest.value as AnyObject)["title"]! as? String {
                    myContent.title = result
                }
                if let result = (rest.value as AnyObject)["articleNum"]! as? String {
                    myContent.articleNum = result
                }
                completion(myContent)
            }
            
        })
    }
    
    
    
}


