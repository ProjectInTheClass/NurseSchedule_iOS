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
    let ref : DatabaseReference! = Database.database().reference().child("Board/")
  
  
    //
    func getMyArticleList(BoardType : String, userId : String, completion : @escaping (String) -> Void){
        ref.child("Board/\(BoardType)/contentList/").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as?
                    DataSnapshot {
                var getUser : String = "getUser error"
                if let contentResult = (rest.value as AnyObject)["user"]! as? String {
                    getUser = contentResult
                }
                completion(getUser)
            }
        })
    }

    
    
    func getMyArticle(serialNum : String, completion : @escaping (MyArticle) -> Void){
        ref.child(" ").observeSingleEvent(of: .value) { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as?
                    DataSnapshot {
                var get : MyArticle = MyArticle(BoardType: "getMyArticleList", serialNum: "getMyArticleList Error", title: "getMyArticleList Error", date: "getMyArticleList Error")
                if let contentResult = (rest.value as AnyObject)["title"] as? String {
                    get.title = contentResult
                }
                if let contentResult = (rest.value as AnyObject)["date"] as? String {
                    get.date = contentResult
                }
                completion(get)
                
            }
            
            
        }
        
    }

}


