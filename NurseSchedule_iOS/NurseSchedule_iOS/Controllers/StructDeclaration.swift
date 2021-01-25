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
    var commentID : String
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

enum Worktype {
    case day
    case evening
    case night
    case off
    case free
    
    var typeStr : String {
        switch self {
        case .day:
            return "day"
        case .evening:
            return "evening"
        case .night:
            return "night"
        case .off:
            return "off"
        case .free:
            return "free"
        }
    }
}

struct ForSavingDayWorkNMemo {
    var date : String
    var worktype : String
    var memo : String
}

struct Day {
    var emoji : String
    var date : String
    var content : String
}
