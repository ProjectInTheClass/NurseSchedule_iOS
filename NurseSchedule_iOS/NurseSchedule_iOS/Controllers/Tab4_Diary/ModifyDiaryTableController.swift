//
//  ModifyDiaryTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/24.
//
import UIKit

class ModifyDiaryTableController: UITableViewController {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var conditionSegController: UISegmentedControl!
    @IBOutlet weak var ModifytextView: UITextView!
    
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
            selectedCondition = 0 //default : ?로 설정
        }
    }
    
    override func viewDidLoad() {
        
        //segmentController을 touch하지 않을 경우를 위한 setting -> default값으로 저장
        super.viewDidLoad()
        self.change.date = self.day?.date ?? "default"
        self.change.emoji = self.day?.emoji ?? 0
        print("viewDidLoad change.emoji -------- \(self.change.emoji)")
    
        DateLabel.text = day?.date
        
        if let storedEmoji = day?.emoji{
            conditionSegController.selectedSegmentIndex = storedEmoji
        }
     
        ModifytextView.text = day?.content
        

        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let writtencontent = ModifytextView.text{
            if writtencontent.isEmpty{
                showAlert(style: .alert)
            }else {
                self.change.content = writtencontent
                print("saveButton seletedCondition -----\(selectedCondition)")
                
                shortDate =  String(self.day?.date.prefix(7) ?? " ")
                print("ShortDate in saveButton(ModifyDiaryController)--------------\(shortDate)")
                
                DBDiary.newDiary.addDiary(userID: currentUser, shortDate: shortDate, new: change)
                
                print("modify > saveButton click------------")
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //alert 띄우기
    func showAlert(style : UIAlertController.Style){
        let alert = UIAlertController(title: "기록이 비었습니다", message: "그대로 저장하시겠습니까?", preferredStyle: style)
        let save = UIAlertAction(title: "저장", style: .default){(action) in //textfield가 비었는데도 저장할 경우
            
            self.change.content = ""//DB에 값 저장
            

      //      self.change.emoji = self.selectedCondition
            print("showAlert seletedCondition -----\(self.selectedCondition)")
            
            self.shortDate =  String(self.day?.date.prefix(7) ?? " ")
            DBDiary.newDiary.addDiary(userID: currentUser, shortDate: self.shortDate, new: self.change)
            print("일기 수정")
            self.dismiss(animated: true, completion: nil)
           
        } //모달창 내리기
        
        let cancel = UIAlertAction(title: "취소", style: .default){(action) in
            print("취소")}
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
