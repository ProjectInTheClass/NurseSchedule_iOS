//
//  ModifyDiaryTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/24.
//
import UIKit
import Firebase

class ModifyDiaryTableController: UITableViewController {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var conditionSegController: UISegmentedControl!
    @IBOutlet weak var ModifytextView: UITextView!
    
    let currentUser = Auth.auth().currentUser?.uid
    
    
    var startViewNDay : [String : Day]? = nil
    
    var startView : String? = nil
    var day : Day? = nil// 기존에 저장되어있던 내용
    
    var writtencontent : String? = nil // 작성된 TextView 내용
    
    var selectedCondition : Int = 0 // segmentedcontrol로 선택된 condition Index를 저정하기 위한 변수
    
    var shortDate : String = " "
    
    //DB로 새로 저장하기 위함
    var change = Day(emoji: 0, date: "default", content: "default")
    
    
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
            day = dataExist[fromViewController]
            self.selectedCondition = self.day?.emoji ?? 0
            self.change.date = self.day?.date ?? "default"
            self.change.emoji = self.day?.emoji ?? 0
            print("viewDidLoad change.emoji -------- \(self.change.emoji)")
        
            DateLabel.text = day?.date
            
            if let storedEmoji = day?.emoji{
                conditionSegController.selectedSegmentIndex = storedEmoji
            }
         
            ModifytextView.text = day?.content

            
        }
        
        //keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
       
        
        //day = startViewNDay[startView]
        
      

        
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if ModifytextView.text.isEmpty {
            showAlert(style: .alert)
        } else {
            saveDB(content: ModifytextView.text)
        }

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveDB(content : String) {
        self.change.content = content

        print("saveButton seletedCondition -----\(selectedCondition)")
        
        self.change.emoji = selectedCondition
        
        shortDate =  String(self.day?.date.prefix(7) ?? " ")
        print("ShortDate in saveButton(ModifyDiaryController)--------------\(shortDate)")
        
        DBDiary.newDiary.addDiary(userID: currentUser!, shortDate: shortDate, new: change)
        
        print("modify > saveButton click------------")
   
        if Array(startViewNDay!.keys)[0] == "DiaryDetailViewController" {
        performSegue(withIdentifier: "unwindToCalendarDiary", sender: nil)
        } else {
        performSegue(withIdentifier: "unwindToDiaryList", sender: nil)
        }
    }
    
    
    //alert 띄우기
    func showAlert(style : UIAlertController.Style){
        let alert = UIAlertController(title: "기록이 비었습니다", message: "그대로 저장하시겠습니까?", preferredStyle: style)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel){(action) in
            print("취소")}
        
        let save = UIAlertAction(title: "저장", style: .default){(action) in //textfield가 비었는데도 저장할 경우
            
            self.change.content = ""//DB에 값 저장
            self.change.emoji = self.selectedCondition
            print("showAlert seletedCondition -----\(self.selectedCondition)")
            
            self.shortDate =  String(self.day?.date.prefix(7) ?? " ")
            DBDiary.newDiary.addDiary(userID: self.currentUser!, shortDate: self.shortDate, new: self.change)
            print("일기 수정")
            //self.dismiss(animated: true, completion: nil)
           // self.performSegue(withIdentifier: "rewindToDiaryList", sender: nil)
            
            self.saveDB(content: "")
            
        } //모달창 내리기
  
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true, completion: nil)
    }
}



//calendar 에서 추가 버튼 누르면 datepicker가 오늘 날짜로 초기화 되어있는거 바꿔야함
extension ModifyDiaryTableController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        writtencontent = ModifytextView.text
        
        print(writtencontent)
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



