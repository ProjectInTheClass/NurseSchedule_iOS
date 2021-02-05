//
//  ModifyDiaryTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/24.
//
import UIKit
import Firebase
import RealmSwift

class ModifyDiaryTableController: UITableViewController {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var conditionSegController: UISegmentedControl!
    @IBOutlet weak var ModifytextView: UITextView!
    
    let realm = try! Realm()
    
    var selectedDate : String = ""
    var startViewNDay : [String : String]? = nil
    var startView : String? = nil
    
    var writtencontent : String? = nil // 작성된 TextView 내용
    var selectedCondition : Int = 0 // segmentedcontrol로 선택된 condition Index를 저정하기 위한 변수
    
    
    @IBAction func SelectCondition(_ sender: Any) { //SegmentController를 touch하였을 경우
        switch conditionSegController.selectedSegmentIndex {
        
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
    
    override func viewDidLoad() {
        
        //segmentController을 touch하지 않을 경우를 위한 set -> default값으로 저장
        super.viewDidLoad()
        
        
        if let dataExist = startViewNDay {
            let fromViewController = Array(startViewNDay!.keys)[0]
            selectedDate = Array(startViewNDay!.keys)[1]
            
            let savedDiary = realm.objects(Diary.self)
            let selectedDiary = savedDiary.filter("date == '\(self.selectedDate)'")
            DateLabel.text = selectedDate
            conditionSegController.selectedSegmentIndex = selectedDiary[0].emoji
            ModifytextView.text = selectedDiary[0].content
            
        }
        
        //keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
      
        let savedDiary = realm.objects(Diary.self)
        let selectedDiary = savedDiary.filter("date == '\(self.selectedDate)'")
        
        try! self.realm.write{
            selectedDiary[0].content = self.ModifytextView.text
            selectedDiary[0].emoji = self.selectedCondition
        }
        
        if Array(startViewNDay!.keys)[0] == "DiaryDetailViewController" {
        performSegue(withIdentifier: "unwindToCalendarDiary", sender: nil)
        } else {
        performSegue(withIdentifier: "unwindToDiaryList", sender: nil)
        }

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
//calendar 에서 추가 버튼 누르면 datepicker가 오늘 날짜로 초기화 되어있는거 바꿔야함
extension ModifyDiaryTableController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        writtencontent = ModifytextView.text
        print("수정함")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.ModifytextView.resignFirstResponder()//키보드 숨기기
 
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
        self.ModifytextView.inputAccessoryView = toolBar//5
    }
    
    
}



