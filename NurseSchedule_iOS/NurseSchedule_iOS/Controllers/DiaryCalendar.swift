//
//  DiaryCalendar.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/17.
//

import UIKit
import Firebase
import FSCalendar


class DiaryCalendar: UIViewController {
    
    var diaryCalendar = FSCalendar()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //diaryCalendar.delegate = self
        //diaryCalendar.dataSource = self
        view.addSubview(diaryCalendar)
        
        diaryCalendar.locale = Locale(identifier: "ko_KR")


    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
