//
//  DBBoard.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/06.
//

import Foundation
import Firebase

//게시판 추가하는 경우

class DBBoard  {
    
    static let board = DBBoard()
    let ref : DatabaseReference! = Database.database().reference().child("Board/")
    
    var boardNum_String : String = ""
    var boardNum_Int : Int = 0
    var newBoardNum : String = "error"

    var countingContent : Int = 0

    func IntToString(boardNum_Int : Int) -> String {
        return String(boardNum_Int)
    }
    
    
    func addContent(BoardType: String, DataType: String, new: Article) {
       /* let reference3 = ref.child("Board/\(BoardType)/\(DataType)/")
        let newContent = ["title": new.title, "content": new.content, "date": new.date, "user":new.user]
        
    //    reference3.setValue(newContent)
        countingContent+=1
        countContent(BoardType: BoardType, DataType: DataType, new: new)
        print("addContent >>> \(newContent)")
 */
        let reference4 = ref.child("\(BoardType)/\(DataType)/\(UUID().uuidString)")
        let newContent = ["title": new.title, "content": new.content, "date": new.date, "user":new.user]
        reference4.setValue(newContent)
        
    }
  
    /*
    func countContent(BoardType: String, DataType: String , new: Article){
        let reference4 = ref.child("Board/\(BoardType)/\(DataType)/\(UUID().uuidString)")
        let newContent = ["title": new.title, "content": new.content, "date": new.date, "user":new.user]
        reference4.setValue(newContent)
    }
     */
    
    /*
    func addBoard(B_maker : String, B_description : String) {
        let reference2 = ref.child("ForNumbering/Board")
        ref.child("ForNumbering/Board").observeSingleEvent(of: .value, with : {
            snapshot in
            //self.boardNum_String = snapshot.value as! String
            self.boardNum_String = snapshot.value as! String
            print("Before increase(String)>>>>>>>>>"+self.boardNum_String)
            //print("readBoardNum() success : \(snapshot.value)")
            let temp = self.boardNum_String
            self.boardNum_Int = Int(temp) ?? -10
            self.boardNum_Int += 1
            print("After increase(Int)>>>>>>>>>\(self.boardNum_Int)")
       
            self.newBoardNum = self.IntToString(boardNum_Int: self.boardNum_Int)
            print("After increase(String)>>>>>>>>>"+self.newBoardNum)
            reference2.setValue(self.newBoardNum)
        
            let boardInfo = ["B_num" : self.newBoardNum,"B_maker" : B_maker, "B_description" : B_description]
            let reference = self.ref.child("Board/"+self.newBoardNum)
            reference.setValue(boardInfo)
        })
    }
    
    */
    
    func getArticleListIn(BoardType: String, completion : @escaping (Article) -> Void) {
        ref.child("\(BoardType)/contentList").observeSingleEvent(of: .value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                var eachArticle = Article(articleID: "", title: "", date: "", content: "", user: "")
                if let result = (rest.value as AnyObject)["content"]! as? String {
                    eachArticle.content = result
                }
                if let result = (rest.value as AnyObject)["date"]! as? String {
                    eachArticle.date = result
                }
                if let result = (rest.value as AnyObject)["title"]! as? String {
                    eachArticle.title = result
                }
                if let result = (rest.value as AnyObject)["user"]! as? String {
                    eachArticle.user = result
                }
                if let result = rest.key as? String{
                    eachArticle.articleID = result
                }
                completion(eachArticle)
                
            }
        })
    }
    
    func addComment(BoardType: String, articleID : String, comment: String) {
        let reference = ref.child("\(BoardType)/contentList/\(articleID)/commentList/\(UUID().uuidString)")
        let dateFormatter : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 0(월단위)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newComment = ["comment": comment, "commentWriter": currentUser, "commentDate": dateFormatter.string(from: Date.init())]
        reference.setValue(newComment)
    }
    
    func getCommentsList(BoardType: String, articleID: String, completion : @escaping (Comment) -> Void) {
        ref.child("\(BoardType)/contentList/\(articleID)/commentList").observeSingleEvent(of: .value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                var comment = Comment(writer: "", date: "", content: "")
                if let result = (rest.value as AnyObject)["comment"]! as? String {
                    comment.content = result
                }
                if let result = (rest.value as AnyObject)["commentDate"]! as? String {
                    comment.date = result
                }
                if let result = (rest.value as AnyObject)["commentWriter"]! as? String {
                    comment.writer = result
                }
                completion(comment)
                
            }
        })
    }
    
    func deleteArticle(BoardType: String, articleID : String) {
        ref.child("\(BoardType)/contentList/\(articleID)").removeValue()
    }
    
    
}
