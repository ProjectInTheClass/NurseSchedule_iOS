//
//  StructDeclaration.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/19.
//

import Foundation


struct Term {
    var definition : String
    var englishTerm : String
    var koreanTerm : String
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


struct Day {
    var emoji : Int
    var date : String
    var content : String
}

