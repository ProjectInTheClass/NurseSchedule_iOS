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
    let ref : DatabaseReference! = Database.database().reference()
    
    var boardNum_String : String = ""
    var boardNum_Int : Int = 0
    var newBoardNum : String = "error"

    var countingContent : Int = 0
    
    let currentUser = Auth.auth().currentUser?.uid

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
        let articleNum = UUID().uuidString
        let reference = ref.child("Board/\(BoardType)/\(DataType)/\(articleNum)")
        let newContent = ["title": new.title, "content": new.content, "date": new.date, "user":new.user]
        reference.setValue(newContent)
        
        let reference2 = ref.child("Users/\(currentUser!)/writtenContent/").childByAutoId()
        let myContent = ["boardType" : BoardType, "date" : new.date, "title" : new.title, "articleNum" : articleNum]
        reference2.setValue(myContent)
        
    }
  
    func getBoardListIn(completion : @escaping (String) -> Void) {
        print("getBoardListIn!!!")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                if let result = rest.key as? String {
                    print("getBoardListIn >>>>>>>>>\(result)")
                    completion(result)
                }
            }
        })
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
        ref.child("Board/\(BoardType)/contentList").queryOrdered(byChild: "date").observeSingleEvent(of: .value) { (snapshot) in
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
        }
    }
    
    
    func getArticleInfoIn(BoardType : String, articleNum : String, completion : @escaping (Article) -> Void) {
        ref.child("Board/\(BoardType)/contentList/\(articleNum)").observeSingleEvent(of: .value) { (snapshot) in
            var detailArticle = Article(articleID: articleNum, title: "myDBBoard_getArticleInfo_title", date: "myDBBoard_getArticleInfo_date", content: "myDBBoard_getArticleInfo_Content", user: "myDBBoard_getArticleInfo_user")
            if let value = snapshot.value as? NSDictionary {
                detailArticle.content = value["content"] as! String
                detailArticle.date = value["date"] as! String
                detailArticle.title = value["title"] as! String
                detailArticle.user = value["user"] as! String
                print("myDBBoard_getArticleInfo >>>>> \(detailArticle)")
                completion(detailArticle)
            } else {
                completion(detailArticle)
            }
            
            }
        }
    
    
    
    
    /* before sorting
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
     */
    
    func getNumberOfCommentsInEachArticle(BoardType:String, articleID: String, completion : @escaping (Int)->Void){
        ref.child("Board/\(BoardType)/contentList/\(articleID)/commentList").observe(.value, with: { snapshot in
            let numberOfCommentsInEachArticle : Int = Int(snapshot.childrenCount)
            print("numberOfCommentsInEachArticle!!!!! \(numberOfCommentsInEachArticle)")
            completion(numberOfCommentsInEachArticle)
        })
    }
    
    
    
    func deleteComment(BoardType: String, articleID: String, commentID: String) {
        ref.child("Board/\(BoardType)/contentList/\(articleID)/commentList/\(commentID)").removeValue()
    }
    
    func addComment(BoardType: String, articleID : String, comment: String) {
        let reference = ref.child("Board/\(BoardType)/contentList/\(articleID)/commentList/\(UUID().uuidString)")
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd, HH:mm:ss"
        let newComment = ["comment": comment, "commentWriter": currentUser!, "commentDate": dateFormatter.string(from: Date.init())]
        reference.setValue(newComment)
    }
    
    func getCommentsList(BoardType: String, articleID: String, completion : @escaping (Comment) -> Void) {
        ref.child("Board/\(BoardType)/contentList/\(articleID)/commentList").queryOrdered(byChild: "commentDate").observeSingleEvent(of: .value, with: { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                var comment = Comment(commentID: "", writer: "", date: "", content: "")
                if let result = (rest.value as AnyObject)["comment"]! as? String {
                    comment.content = result
                }
                if let result = (rest.value as AnyObject)["commentDate"]! as? String {
                    let index = result.firstIndex(of: ",") ?? result.endIndex
                    let beginning = result[..<index]
                    comment.date = String(beginning)
                }
                if let result = (rest.value as AnyObject)["commentWriter"]! as? String {
                    comment.writer = result
                }
                if let result = rest.key as? String{
                    comment.commentID = result
                }
                completion(comment)
                
            }
        })
    }
    
    func deleteArticle(BoardType: String, articleID : String) {
        ref.child("Board/\(BoardType)/contentList/\(articleID)").removeValue()
    }
    
    func editContent(BoardType: String, update: Article, articleID : String) {
        let reference = ref.child("\(BoardType)/contentList/\(articleID)")
        let newContent = ["title": update.title, "content": update.content, "date": update.date, "user":update.user]
        reference.setValue(newContent)
    }
    
    
    
    func getRecentNotice(completion: @escaping (String) -> Void) {
        
        ref.child("공지사항/contentList").observeSingleEvent(of: .value, with: { snapshot in
            while let rest = snapshot.children.nextObject() as? DataSnapshot {
                var recentArticle = Article(articleID: "", title: "", date: "", content: "", user: "")
                if let result = (rest.value as AnyObject)["title"]! as? String {
                    recentArticle.title = result
                }
                completion(recentArticle.title)
                return
            }
        })
    }
}
