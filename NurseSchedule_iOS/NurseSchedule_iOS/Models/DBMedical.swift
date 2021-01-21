//
//  DBMedical.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/21.
//

import Foundation
import Firebase


class DBMedical {
    
    let ref : DatabaseReference! = Database.database().reference()
    static let medicalBookData = DBMedical()
    
    
    func getMedicalBookData(completion : @escaping (Term) -> Void) {
        ref.child("Medical/").observeSingleEvent(of: .value, with: { snapshot in
//            self.diarycellCount = Int(snapshot.childrenCount)
//            print("snapshot.childrencount ->  \(snapshot.childrenCount)")
//            guard let value = snapshot.value as? [String: Any] else{
//                return
//            }
//            //   print("Value: \(value)")
//            // print(snapshot)
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                // print(rest.value)
                var eachTerm = Term(definition: "", englishTerm: "", koreanTerm: "")
                if let result = (rest.value as AnyObject)["N_definition"]! as? String {
                    //    print(result)
                    eachTerm.definition = result
                }
                if let result = (rest.value as AnyObject)["N_englishName"]! as? String {
                    //   print(result)
                    eachTerm.englishTerm = result
                }
                if let result = (rest.value as AnyObject)["N_koreanName"]! as? String {
                    //   print(result)
                    eachTerm.koreanTerm = result
                }
                completion(eachTerm)
                
            }
        })
    }
}

