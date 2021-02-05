//
//  DBMedicalBook.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/02/05.
//

import Foundation
import RealmSwift

class MedicalBook: Object {
    
    static let medicalBook = MedicalBook()
    
    @objc dynamic var englishTerm : String = ""
    @objc dynamic var koreanTerm : String = ""
    @objc dynamic var explanation : String = ""
    
    
//    
//    
//    func csvToArray () -> [String] {
//       if let csvPath = Bundle.main.path (forResource: "보건의료용어표준_v5.0_간호", ofType: "csv") {
//          do {
//             let csvStr = try String (contentsOfFile: csvPath, encoding: String.Encoding.utf8)
//             let csvArr = csvStr.components (separatedBy:"\r")
//            print("csvArr[1]")
//            print(csvArr.count)
//            print(csvArr[1].split(separator: ",")[0])
//            print(csvArr[1].split(separator: ",")[1])
//            print(csvArr[1].split(separator: ",")[2])
//            print(csvArr[100].split(separator: ",")[0])
//            print(csvArr[100].split(separator: ",")[1])
//            print(csvArr[100].split(separator: ",")[2])
//            return csvArr
//            
//          } catch let error as NSError {
//             print (error.localizedDescription)
//          }
//       }
//        return ["never be printed"]
//    }

}
