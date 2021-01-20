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
    @IBOutlet weak var memoView: UITableView!
    
    let dateFormatter = DateFormatter()
    var selectedDate : Date = .init()
    var workTypesList : [ String : WorkType] = [ : ]
    
    var memoList: [String] = []
    
    //var events : [ Date : WorkType ] = [ Date.init() : .DAY ]
    //var events : WorkType = .DAY
    
    //FSCalendar
    //https://ahyeonlog.tistory.com/7
    
    override func viewDidLoad() {
        let currentUser = Login.init().googleLogin()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendar.delegate = self
        calendar.dataSource = self
        
       
        
         DBMemo.newMemo.getWorkType(userID: currentUser, completion: { (typesFromDB) in
            self.workTypesList[typesFromDB.date] = typesFromDB.workType
            print("worktypes!!!!!>>>\(self.workTypesList)")
            //self.calendar.reloadData()
        })
        
        
        memoView.delegate = self
        memoView.dataSource = self
        memoView.reloadData()
        // print("tableView>>>>> \(term)")
        
        super.viewDidLoad()
        
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    //창 가려졌다가 다시 보이거나 암튼 내 화면 다시 보이게 될 때
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
        memoView.reloadData()
        calendar.reloadData()
    }
    
    func updateUI() {
        //calendar
        
        //memoview와 view 구분 임시..
        let colorLiteral = #colorLiteral(red: 0.9211722016, green: 0.967481792, blue: 0.8859727979, alpha: 1)
        calendar.backgroundColor = colorLiteral
        
        
        // 날짜 여러개 선택 가능하게
        calendar.allowsMultipleSelection = false
        
        // 날짜 스와프해서 여러개 선택되도록
        calendar.swipeToChooseGesture.isEnabled = true
        
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
        calendar.appearance.subtitleFont = UIFont.boldSystemFont(ofSize: 30)
        
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
    
    @IBAction func unwindFromAddMemo(segue : UIStoryboardSegue) {
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewMemo" {
            let viewcontollerToAddNewMemo = segue.destination as! ScheduleAddViewController
            viewcontollerToAddNewMemo.selectedDate = sender as! Date
        }
    }
    
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
    
    // 메모 추가 버튼 눌렀을 때 발생되는 액션
    @IBAction func addMemoButtonTapped(_ sender: Any) {
        addNewEvent(selectedDate: selectedDate)
    }
    
    func addNewEvent(selectedDate date:Date){
        performSegue(withIdentifier: "addNewMemo", sender: selectedDate)
    }
}

extension ScheduleController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 메모 계층 아래에
        // 선택(selectedDate)날짜 계층 아래에
        // 메모 정리되도록 디비 넣어서
        // 메모/selectedDate해서 디비 읽어와서 배열에 저장해서 생성한다.
        // 그 배열.count를 return 시키면 될거같아
        return self.memoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.memoView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        let data = self.memoList[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }
}

extension ScheduleController : FSCalendarDelegateAppearance {
    
    //선택한 날짜 색깔 변경
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
    //        switch dateFormatter.string(from:date) {
    //        //색깔 넣어보자
    //        case "2021-01-01":
    //            return .yellow
    //        case "2021-01-02":
    //            return .orange
    //        case "2021-01-03":
    //            return .green
    //        case "2021-01-04":
    //            return .white
    //        default :
    //            return .systemPink
    //        }
    //    }
    /*
     //색깔이 나타나긴 하는데 무한 부팅되면서 날짜를 선택할 수도 없음. 캘린더 얼어버림.
     //모든 날짜들에 대한 색을 표현하려고 하다보니 그러는듯.
     
     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
     let currentUser = Login.init().googleLogin()
     DBMemo.newMemo.getWorkType(userID: currentUser, date: dateFormatter.string(from:date), completion: { worktype in
     switch worktype {
     case "DAY" :
     self.workTypesList[self.dateFormatter.string(from:date)] = UIColor.yellow
     case "EVENING" :
     self.workTypesList[self.dateFormatter.string(from:date)] = UIColor.orange
     case "NIGHT" :
     self.workTypesList[self.dateFormatter.string(from:date)] = UIColor.green
     case "OFF" :
     self.workTypesList[self.dateFormatter.string(from:date)] = UIColor.gray
     default :
     self.workTypesList[self.dateFormatter.string(from:date)] = UIColor.gray
     }
     self.calendar.reloadData()
     })
     //calendar.reloadData()
     return self.workTypesList[self.dateFormatter.string(from:date)]
     }
     */
    /*
     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
     switch events[date] {
     case .DAY:
     return .yellow
     case .EVENING:
     return .orange
     case .NIGHT:
     return .green
     case .OFF:
     return .gray
     default :
     return .gray
     }
     }
     */
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        //        let currentUser = Login.init().googleLogin()
        //       let key = self.dateFormatter.string(from: date)
        //            if let color = workTypesList[key]?.color {
        //                return color
        //            }
        //            return nil
        //        }
//        let currentUser = Login.init().googleLogin()
//        DBMemo.newMemo.getWorkType(userID: currentUser,completion: { (worktype) in
//            workTypesList[self.dateFormatter.string(from: date)] = worktype
//        })
        let key = self.dateFormatter.string(from: date)
        if let type = workTypesList[key] {
            switch type {
            case .DAY:
                return .yellow
            case .EVENING:
                return .orange
            case .NIGHT:
                return .green
            case .OFF:
                return .gray
            }
            //return color
        }
        return nil
    }
 
 
}

extension ScheduleController : FSCalendarDelegate, FSCalendarDataSource {
    // 날짜 선택 시 콜백 메소드
    //모달 창으로 이벤트 추가
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        selectedDate = date
        
        let currentUser = Login.init().googleLogin()
        DBMemo.newMemo.getMemo(userID: currentUser, date: dateFormatter.string(from:selectedDate), completion: { memo in
            self.memoList = memo
            self.memoView.reloadData()
        })
        memoView.reloadData()
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.titleDefaultColor = .none
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    
    
    // 날짜 밑에 문자열을 표시
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        let key = self.dateFormatter.string(from: date)
        if let type = workTypesList[key] {
            switch type {
            case .DAY:
                return "☀️"
            case .EVENING:
                return "🌝"
            case .NIGHT:
                return "🌑"
            case .OFF:
                return "💤"
            }
            //return color
        }
        return nil
    }
    
    //날짜 글씨 자체를 바꿔버릴 수 있고
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        switch dateFormatter.string(from: date) {
        case "":
            return "D-day"
        default:
            return nil
        }
    }
    
    
    //날짜 최대 선택 가능 개수
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        // 날짜 3개까지만 선택되도록
        if calendar.selectedDates.count > 1 {
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
