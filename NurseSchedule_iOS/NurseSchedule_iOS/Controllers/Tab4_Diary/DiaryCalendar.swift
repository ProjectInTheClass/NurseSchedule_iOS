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

    
    // 달력이미지 꾸미기(캘린더와 같은 버전)
    func updateUI() {
        //calendar
        
        //memoview와 view 구분 임시..
//        let colorLiteral = #colorLiteral(red: 0.9211722016, green: 0.967481792, blue: 0.8859727979, alpha: 1)
//        calendar.backgroundColor = colorLiteral
        
        
        // 날짜 여러개 선택 가능하게
        diaryCalendar.allowsMultipleSelection = false
        
        // 날짜 스와프해서 여러개 선택되도록
        diaryCalendar.swipeToChooseGesture.isEnabled = true
        
        // 선택된 날짜의 모서리 설정 ( 0으로 하면 사각형으로 표시 )
        diaryCalendar.appearance.borderRadius = 3
        // 스와이프 스크롤 작동 여부 ( 활성화하면 좌측 우측 상단에 다음달 살짝 보임, 비활성화하면 사라짐 )
        diaryCalendar.scrollEnabled = true
        // 스와이프 스크롤 방향 ( 버티칼로 스와이프 설정하면 좌측 우측 상단 다음달 표시 없어짐, 호리젠탈은 보임 )
        diaryCalendar.scrollDirection = .vertical
        
        // 날짜 선택됐을 때
        // 타이틀 컬러
        diaryCalendar.appearance.titleSelectionColor = .black
        // 서브 타이틀 컬러
        diaryCalendar.appearance.subtitleSelectionColor = .black
        diaryCalendar.appearance.subtitleFont = UIFont.boldSystemFont(ofSize: 30)
        
        // 달력의 평일 날짜 색깔
        diaryCalendar.appearance.titleDefaultColor = .black
        
        // 달력의 토,일 날짜 색깔
        diaryCalendar.appearance.titleWeekendColor = .gray
        
        // 달력의 맨 위의 년도, 월의 색깔
        diaryCalendar.appearance.headerTitleColor = .black
        
        // 달력의 요일 글자 색깔
        diaryCalendar.appearance.weekdayTextColor = .black
        
        // 달력의 오늘 색깔
        diaryCalendar.appearance.todayColor = #colorLiteral(red: 0.6445949674, green: 0.9079375863, blue: 0.5924149752, alpha: 1)
        
        
        // 달력의 년월 글자 바꾸기
        diaryCalendar.appearance.headerDateFormat = "YYYY년 M월"
        
        // 달력의 요일 글자 바꾸는 방법 1
        diaryCalendar.locale = Locale(identifier: "ko_KR")
        
        // 년월에 흐릿하게 보이는 애들 없애기 0: 없앰 , 1: 뚜렷
        diaryCalendar.appearance.headerMinimumDissolvedAlpha = 0
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()
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

