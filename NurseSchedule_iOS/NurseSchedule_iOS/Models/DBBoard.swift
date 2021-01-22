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

    func IntToString(boardNum_Int : Int) -> String {
        return String(boardNum_Int)
    }
    
    func countContent(BoardType: String, DataType: String , new: InputTable){
        
        let reference4 = ref.child("Board/\(BoardType)/\(DataType)/\(self.countingContent)")
        
        let newContent = ["title": new.title, "content": new.content, "date": new.date, "user":new.user]
        
        reference4.setValue(newContent)
        
        
    }
    
    
    func addContent(BoardType: String, DataType: String, new: InputTable) {
        
        let reference3 = ref.child("Board/\(BoardType)/\(DataType)/")
        
        
        
        let newContent = ["title": new.title, "content": new.content, "date": new.date, "user":new.user]
        
    //    reference3.setValue(newContent)
        
        countingContent+=1
        
        countContent(BoardType: BoardType, DataType: DataType, new: new)
        
        print("addContent >>> \(newContent)")
        
        
    }
    
    
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
}
