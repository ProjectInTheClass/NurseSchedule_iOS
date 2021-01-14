//
//  ScheduleController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase
import FSCalendar

class ScheduleController: UIViewController{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarBottom: NSLayoutConstraint!
    
    let dateFormatter = DateFormatter()
    
    
    //FSCalendar
    //https://ahyeonlog.tistory.com/7
    
    override func viewDidLoad() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendar.delegate = self
        calendar.dataSource = self
        super.viewDidLoad()
        
        //캘린더 위로 올라가게
        //calendarBottom.constant = 300
        
        //let test = DBUser.users.setUser(userName : "lee" ,userEmail : "lee@dgu.ac.kr")
        //DBUser.users.getUser(test)
        updateUI()
        
        //uid confirm
        //Auth.auth().addIDTokenDidChangeListener { (auth, user) in
        //self.updateUI()
        //}
        // Do any additional setup after loading the view.
    }
    
    //창 가려졌다가 다시 보이거나 암튼 내 화면 다시 보이게 될 때
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        //calendar
        
        // 날짜 여러개 선택 가능하게
        calendar.allowsMultipleSelection = false
        
        // 날짜 스와프해서 여러개 선택되도록
        calendar.swipeToChooseGesture.isEnabled = true
        
        // 선택한 날짜 표시 색깔
        calendar.appearance.selectionColor = UIColor.yellow
        
        // 오늘 날짜 색깔
        calendar.appearance.todayColor = UIColor.orange
        
        // 선택된 날짜의 모서리 설정 ( 0으로 하면 사각형으로 표시 )
        calendar.appearance.borderRadius = 0
        // 스와이프 스크롤 작동 여부 ( 활성화하면 좌측 우측 상단에 다음달 살짝 보임, 비활성화하면 사라짐 )
        calendar.scrollEnabled = true
        // 스와이프 스크롤 방향 ( 버티칼로 스와이프 설정하면 좌측 우측 상단 다음달 표시 없어짐, 호리젠탈은 보임 )
        calendar.scrollDirection = .vertical
        
        // 날짜 선택됐을 때
        // 타이틀 컬러
        calendar.appearance.titleSelectionColor = .black
        // 서브 타이틀 컬러
        calendar.appearance.subtitleSelectionColor = .black
        
        // 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black

        // 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .red

        // 달력의 맨 위의 년도, 월의 색깔
        calendar.appearance.headerTitleColor = .systemPink

        // 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .brown
        
        
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월"

        // 달력의 요일 글자 바꾸는 방법 1
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 년월에 흐릿하게 보이는 애들 없애기 0: 없앰 , 1: 뚜렷
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func capture(_ sender: Any) {
        captureScreenshot()
        
    }
    
    //스크린샷
    func captureScreenshot(){
        let layer = self.calendar.layer
        let scale = UIScreen.main.scale
        // Creates UIImage of same size as view
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // THIS IS TO SAVE SCREENSHOT TO PHOTOS
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
        // screenshot effect
        if let window = self.view{
            
            let calenderView = UIView(frame: window.bounds)
            calenderView.backgroundColor = UIColor.white
            calenderView.alpha = 1
            
            window.addSubview(calenderView)
            UIView.animate(withDuration: 1, animations: {
                calenderView.alpha = 0.0
            }, completion: {(finished:Bool) in
                calenderView.removeFromSuperview()
            })
        }
    }
    
}

extension ScheduleController : FSCalendarDelegateAppearance {
    //날짜별로 선택 컬러 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        
        switch dateFormatter.string(from: date) {
        case "2021-01-12":
            return .green
        case "2021-01-13":
            return .yellow
        case "2021-01-14":
            return .red
        default:
            return appearance.selectionColor
        }
    }
    
    
    
}

extension ScheduleController : FSCalendarDelegate, FSCalendarDataSource {
    // 날짜 선택 시 콜백 메소드
    //모달 창으로 이벤트 추가
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    // 날짜 밑에 문자열을 표시
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "오늘"
        case "2021-01-12":
            return "출근"
        case "2021-01-13":
            return "지각"
        case "2021-01-14":
            return "결근"
        default:
            return nil
        }
    }
    
    //날짜 글씨 자체를 바꿔버릴 수 있고
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        switch dateFormatter.string(from: date) {
        case "2021-01-28":
            return "D-day"
        default:
            return nil
        }
    }
    
 
    //날짜 최대 선택 가능 개수
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        // 날짜 3개까지만 선택되도록
        if calendar.selectedDates.count > 0 {
            return false
        } else {
            return true
        }
    }
    
    //날짜 선택해제
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        //선택해제 불가능
        //return false
        
        // 선택해제 가능
        return true
    }
    


    
    
}
