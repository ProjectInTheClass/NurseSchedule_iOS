//
//  DBTest.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import Foundation


class DBTest: NSObject {
    var serialNum: String        /** 최신버젼 코드     */
       var name: String        /** 최신버젼 명      */
       var email: String
    
    init(serialNum :String, name :String, email:String) {
            self.serialNum = serialNum
            self.name = name
            self.email = email
        }
}
