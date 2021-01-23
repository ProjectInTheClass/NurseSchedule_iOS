//
//  StructDeclaration.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/19.
//

import Foundation

struct Users {
    //childByAutoId()
    //let serialNum : String
    let name : String
    let email : String
}


struct Term {
    var definition : String
    var englishTerm : String
    var koreanTerm : String
}



struct Article {
    var articleID : String
    var title: String
    var date: String
    var content: String
    var user: String
}


struct ForCommentSavingInfo {
    var boardType : String
    var newComment : Article
    
}

struct Comment {
    var writer : String
    var date : String
    var content : String
    
}
