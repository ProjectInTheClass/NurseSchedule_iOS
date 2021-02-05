//
//  AddDiaryTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/19.
//

import UIKit
import RealmSwift

class AddDiaryTableController: UITableViewController {
    static let addDiaryController = AddDiaryTableController()
    
    @IBOutlet weak var SelectedDate: UILabel!
    @IBOutlet weak var conditionSegment: UISegmentedControl!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let realm = try! Realm()
    
    //DateFormatter
    let dateFormatter1 : DateFormatter = DateFormatter() //DB에 들어갈 날짜용(일단위)
    let dateFormatter2 : DateFormatter = DateFormatter() //Label로 보여주기 위함(-월-일)
    
    var selectedDate : String = "" //DB에 저장될 날짜 dateFormatter1로
    var selectedCondition : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dateForamatting
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        dateFormatter2.dateFormat = "M월dd일"
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        var today = Date.init()
        datePicker.maximumDate = today //오늘 이후 날짜 datepicker에서 선택 하지 못하게
        self.selectedDate = dateFormatter1.string(from: today)//datepicker선택하지 않아도 오늘 날짜로 픽스
        SelectedDate.text = dateFormatter2.string(from: today)//atepicker선택하지 않아도 오늘 날짜로 label에 출력
        selectedCondition = 0 //condition을 선택하지 않아도 픽스
        
        
        //keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    //datePicker 선택 시 실행
    @IBAction func SelectDate(_ sender: UIDatePicker){
        self.selectedDate = dateFormatter1.string(from: sender.date)//datepicker 날짜로 변경
        self.SelectedDate.text = dateFormatter2.string(from: sender.date)//datepicker 날짜로 변경
    }
    
    //segmentControl 작동 시 해당되는 emoji를 seletedCondition에 Int형식으로 저장
    @IBAction func SelectCondition(_ sender: Any) {
        switch conditionSegment.selectedSegmentIndex {
        case 0:
            selectedCondition = 0
        case 1:
            selectedCondition = 1
        case 2:
            selectedCondition = 2
        case 3:
            selectedCondition = 3
        case 4:
            selectedCondition = 4
        default:
            selectedCondition = 0
        }
    }
    
    //저장버튼 클릭 시
    @IBAction func clickedSaveButton(_ sender: Any) {
        //중복되었는지 구현하기
        //만약 중복되었다면
        //        showCheckAlert()
        
        let savedDiary = realm.objects(Diary.self)
        let selectedDiary = savedDiary.filter("date == '\(self.selectedDate)'")
        
        if selectedDiary.isEmpty{
            let dayDiary = Diary()
            dayDiary.content = contentTextView.text
            dayDiary.date = self.selectedDate
            dayDiary.emoji = self.selectedCondition
            
            try! self.realm.write {
                self.realm.add(dayDiary)
            }
        } else {
            let alert = UIAlertController(title: "이미 작성된 일기가 있습니다.", message: "덮어씌우겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let save = UIAlertAction(title: "확인", style: .default){(action) in
                
                try! self.realm.write {
                    //                    selectedDiary[0].date = self.selectedDate
                    selectedDiary[0].content = self.contentTextView.text
                    selectedDiary[0].emoji = self.selectedCondition
                }
                self.dismiss(animated: true, completion: nil)
                print("일기 덮어 저장")
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel){(action) in
                print("취소")
            }
            alert.addAction(save)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
        print("새 일기 작성 저장")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



extension AddDiaryTableController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //writtenDiary = contentTextView.text
        self.contentTextView.resignFirstResponder()//키보드 숨기기
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.contentTextView.inputAccessoryView = toolBar//5
    }
    
    
}



