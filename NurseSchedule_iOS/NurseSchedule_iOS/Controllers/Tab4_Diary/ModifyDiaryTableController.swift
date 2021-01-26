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
    var seletedCondition : String = " " // segmentedcontrol로 선택된 condition값
    var conditionIndex : Int = 0 //기존에 선택된 condition값에 대한 Index
    
    var shortDate : String = " "
    
    //DB로 새로 저장하기 위함
    var change = Day(emoji: "default", date: "default", content: "default")
    
    //string -> index
    func setConditionIndex(change : Day ){
        var condition : String = change.emoji
        switch condition {
        case "😊":
            conditionIndex = 0
        case "🥰":
            conditionIndex = 1
        case "😢":
            conditionIndex = 2
        case "🤒":
            conditionIndex = 3
        case "😡":
            conditionIndex = 4
        default :
            print("❔")
        }
    }
    
    @IBAction func SelectCondition(_ sender: Any) {
        switch conditionSegController.selectedSegmentIndex {
        case 0:
            seletedCondition = "😊"
        case 1:
            seletedCondition = "🥰"
        case 2:
            seletedCondition = "😢"
        case 3:
            seletedCondition = "🤒"
        case 4:
            seletedCondition = "😡"
        default:
            seletedCondition = "❔"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.change.date = self.day?.date ?? "default"
        self.change.emoji = self.day?.emoji ?? "default"
        
        var emoji = day?.emoji
        setConditionIndex(change: day ?? Day(emoji: "\(emoji)" , date:  " " , content: " "))
        
        DateLabel.text = day?.date
        conditionSegController.selectedSegmentIndex = conditionIndex
        ModifytextView.text = day?.content
        

        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let writtencontent = ModifytextView.text{
            if writtencontent.isEmpty{
                showAlert(style: .alert)
            }else {
                self.change.content = writtencontent
                
                if let dayemoji = day?.emoji{
                    seletedCondition = dayemoji
                }
              
                
                self.change.emoji = self.seletedCondition
                
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
            self.change.emoji = self.seletedCondition//DB에 값 저장
            
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
