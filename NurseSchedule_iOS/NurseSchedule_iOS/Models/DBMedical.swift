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
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                var eachTerm = Term(definition: "", englishTerm: "", koreanTerm: "")
                if let result = (rest.value as AnyObject)["N_definition"]! as? String {
                    eachTerm.definition = result
                }
                if let result = (rest.value as AnyObject)["N_englishName"]! as? String {
                    eachTerm.englishTerm = result
                }
                if let result = (rest.value as AnyObject)["N_koreanName"]! as? String {
                    eachTerm.koreanTerm = result
                }
                completion(eachTerm)
                
            }
        })
    }
}

