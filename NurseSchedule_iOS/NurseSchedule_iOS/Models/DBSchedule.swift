//
//  DBSchedule.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/02/04.
//

import Foundation
import RealmSwift

class DBSchedule: Object {
    @objc dynamic var date : String = ""
    @objc dynamic var worktype : String = ""
    @objc dynamic var memo : String = ""
}
