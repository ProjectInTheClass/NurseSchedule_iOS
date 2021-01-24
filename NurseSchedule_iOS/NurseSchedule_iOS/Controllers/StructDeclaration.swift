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


struct ArticleAllInfo {
    var boardType : String
    var articleInfo : Article
    
}

struct Comment {
    var writer : String
    var date : String
    var content : String
    
}

enum ActionType {
    case edit
    case delete
    
    var typeStr : String {
        switch self {
        case .edit:
            return "수정"
        case .delete:
            return "삭제"
        }
    }
}



struct Day {
    var emoji : String
    var date : String
    var content : String
}
