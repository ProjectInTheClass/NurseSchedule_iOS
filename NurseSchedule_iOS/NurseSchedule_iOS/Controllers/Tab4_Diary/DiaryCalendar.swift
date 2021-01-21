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
    
    @IBOutlet weak var diaryCalendar: FSCalendar!

    
    let dateFormatter = DateFormatter()
    var dayDiary = Day(emoji: "DiaryCalendar_default_emoji", date: "DiaryCalendar_default_date", content: "DiaryCalendar_default_content")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryCalendar.delegate = self
        diaryCalendar.dataSource = self
        //view.addSubview(diaryCalendar)
    

        // Do any additional setup after loading the view.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "popCalendarDiary" {
           let DiaryDetailViewController = segue.destination as! DiaryDetailViewController
           DiaryDetailViewController.detailInfoFromDay = sender as? Day
       }
    }
    
    @IBAction func unwindToCalendarDiary(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}
//extension DiaryCalendar : FSCalendarDelegateAppearance {
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//    }
//}


extension DiaryCalendar : FSCalendarDelegate , FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("\(date) 선택됨")
        
        let currentUser = Login.init().googleLogin()
            DBDiary.newDiary.getDayDiary(userID: currentUser, date: date) { (result) in
                if result != nil {
                    self.dayDiary = result!
                    self.performSegue(withIdentifier: "popCalendarDiary", sender: self.dayDiary)
                } else {
                    let alert = UIAlertController(title: "잠깐만!", message: "작성된 일기가 없어요ㅠㅠ", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                }
                
            }
        }
        
}

