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
            //print("ScheduleController.worktypes!!!!!>>>\(self.workTypesList)")
            self.calendar.reloadData()
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
//        let colorLiteral = #colorLiteral(red: 0.9211722016, green: 0.967481792, blue: 0.8859727979, alpha: 1)
//        calendar.backgroundColor = colorLiteral
        
        
        // 날짜 여러개 선택 가능하게
        calendar.allowsMultipleSelection = false
        
        // 날짜 스와프해서 여러개 선택되도록
        calendar.swipeToChooseGesture.isEnabled = true
        
        // 선택된 날짜의 모서리 설정 ( 0으로 하면 사각형으로 표시 )
        calendar.appearance.borderRadius = 3
        // 스와이프 스크롤 작동 여부 ( 활성화하면 좌측 우측 상단에 다음달 살짝 보임, 비활성화하면 사라짐 )
        calendar.scrollEnabled = true
        // 스와이프 스크롤 방향 ( 버티칼로 스와이프 설정하면 좌측 우측 상단 다음달 표시 없어짐, 호리젠탈은 보임 )
        calendar.scrollDirection = .vertical
        
        
        
        // 달력의 오늘 색깔
//        calendar.appearance.todayColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//        calendar.appearance.titleTodayColor = .white
        // 오늘인데 선택되면
//        calendar.appearance.todaySelectionColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        // 날짜 선택됐을 때
        // 달력의 선택한 색깔
//        calendar.appearance.selectionColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        // 타이틀 컬러
        calendar.appearance.titleSelectionColor = .white
        // 서브 타이틀 컬러
        calendar.appearance.subtitleSelectionColor = .white
        calendar.appearance.subtitleFont = UIFont.boldSystemFont(ofSize: 30)
        
        // 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black
        
        // 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .gray
        
        // 달력의 맨 위의 년도, 월의 색깔
       calendar.appearance.headerTitleColor = .black
        
        // 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .black
        
        // date selection with square
        calendar.appearance.borderRadius = 0
        
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "삭제하시겠습니까?", message: "되돌이킬수없어요😭", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                self.dateFormatter.dateFormat = "yyyy-MM-dd"
                DBMemo.newMemo.deleteMemo(date : self.dateFormatter.string(from:self.selectedDate), index: indexPath.row)
                self.memoList.remove(at: indexPath.row)
                self.memoView.deleteRows(at: [indexPath], with: .automatic)
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
            
            
        }
    }
    
    
}

extension ScheduleController : FSCalendarDelegateAppearance {
    /*
    // 근무타입에 따른 색깔
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
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
        }
        return nil
    }
 */
 
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
        } else {
            return " "
        }
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
