//
//  DBDiary.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/02/04.
//

import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var date : String = "defaultDate"
    @objc dynamic var content : String = "defaultContent"
    @objc dynamic var emoji : Int = 0
}
