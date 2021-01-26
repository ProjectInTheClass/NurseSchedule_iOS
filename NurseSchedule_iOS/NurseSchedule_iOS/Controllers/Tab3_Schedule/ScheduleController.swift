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
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var workTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var memoTextView: UITextView!
    
    
    let dateFormatter = DateFormatter()
    var selectedDate : Date = .init()
    var showDaySchedule : ForSavingDayWorkNMemo = ForSavingDayWorkNMemo(date: "", worktype: "", memo: "")
    var showDayWorkType : [String : String] = [ : ]
    
    //FSCalendar
    //https://ahyeonlog.tistory.com/7
    
    override func viewDidLoad() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendar.delegate = self
        calendar.dataSource = self
        memoTextView.delegate = self
        
        //keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        DBMemo.newMemo.getWorkType { (dayWorkType) in
            
            print("getwrok!!!!!!!!!!!!!!!!!!!")
            self.showDayWorkType[dayWorkType.date] = dayWorkType.worktype
            self.calendar.reloadData()
        }
        print("getWorkType didLoad >>>>> \(showDayWorkType)")
        
        
        super.viewDidLoad()
        
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    //창 가려졌다가 다시 보이거나 암튼 내 화면 다시 보이게 될 때
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
        calendar.reloadData()
    }
    
    func updateUI() {
        
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
        
        selectedDateLabel.text = dateFormatter.string(from: selectedDate)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
    }
    
    @IBAction func unwindFromAddMemo(segue : UIStoryboardSegue) {
        
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
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "저장하시겠습니까?", message: "언제든지 수정가능해요!😊", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            let savingDate = self.dateFormatter.string(from: self.selectedDate)
            var savingWorktype : String {
                switch self.workTypeSegmentedControl.selectedSegmentIndex {
                case 0:
                    return Worktype.day.typeStr
                case 1:
                    return Worktype.evening.typeStr
                case 2:
                    return Worktype.night.typeStr
                case 3:
                    return Worktype.off.typeStr
                case 4:
                    return Worktype.free.typeStr
                default:
                    return "error"
                }
            }
            var savingMemo = ""
            if let memo = self.memoTextView.text {
                savingMemo = memo
            }
            
            let forSavingDayWorkNMemo = ForSavingDayWorkNMemo(date: savingDate, worktype: savingWorktype, memo: savingMemo)
            DBMemo.newMemo.addDaySchedule(newDay : forSavingDayWorkNMemo)
            
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
        
        
    }
}


extension ScheduleController : FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        
        selectedDateLabel.text = dateFormatter.string(from: selectedDate)
        DBMemo.newMemo.getDaySchedule(date: dateFormatter.string(from: selectedDate), completion: { (dayScheduleFromDB) in
            self.showDaySchedule = dayScheduleFromDB
            switch self.showDaySchedule.worktype {
            case "day":
                self.workTypeSegmentedControl.selectedSegmentIndex = 0
            case "evening":
                self.workTypeSegmentedControl.selectedSegmentIndex = 1
            case "night":
                self.workTypeSegmentedControl.selectedSegmentIndex = 2
            case "off":
                self.workTypeSegmentedControl.selectedSegmentIndex = 3
            case "free":
                self.workTypeSegmentedControl.selectedSegmentIndex = 4
            default :
                self.workTypeSegmentedControl.selectedSegmentIndex = 0
            }
            self.memoTextView.text = self.showDaySchedule.memo
            if self.memoTextView.text.isEmpty {
                self.memoTextViewPlaceholderSetting()
            } else {
                self.memoTextView.textColor = UIColor.black
            }
        })
    }
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.titleDefaultColor = .none
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let date = dateFormatter.string(from: date)
        if let type = showDayWorkType[date] {
            switch type {
            case "day":
                return UIImage(named: "day")!
            case "evening":
                return UIImage(named: "evening")!
            case "night":
                return UIImage(named: "night")!
            case "off":
                return UIImage(named: "off")!
            case "free":
                return UIImage(named: "free")!
            default :
                return UIImage.init()
            }
        }
        return nil
    }
    
    // 메모 있는 날은 이벤트 dot 표시
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        DBMemo.newMemo.getDaySchedule(date: dateFormatter.string(from: selectedDate as Date), completion: { (dayScheduleFromDB) in
            self.showDaySchedule = dayScheduleFromDB
        })
        if self.showDaySchedule.memo != "" {
            return true
        } else {
            return false
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

extension ScheduleController : UITextViewDelegate {
    func memoTextViewPlaceholderSetting() {
        memoTextView.text = "메모가 없어요😓"
        memoTextView.textColor = UIColor.lightGray
        
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -200 // Move view 150 points upward
        
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = +85 // Move view to original position
    }
    
    
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.memoTextView.inputAccessoryView = toolBar//5
    }
}
