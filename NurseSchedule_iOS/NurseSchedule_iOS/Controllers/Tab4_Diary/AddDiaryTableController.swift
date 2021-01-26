//
//  AddDiaryTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/19.
//

import UIKit

class AddDiaryTableController: UITableViewController {
    
    
    static let addDiaryController = AddDiaryTableController()
    
  @IBOutlet weak var SelectedDate: UILabel!
    @IBOutlet weak var conditionSegment: UISegmentedControl!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    let dateFormatter : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 0(월단위)
    let dateFormatter1 : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 1 (일단위)
    let dateFormatter2 : DateFormatter = DateFormatter() //Label로 보여주기용
    
    var selectedDate : String = ""
    var todayDate : String = " "
    var showDate : String = " "
    
    //DB로 값을 보내기 위함
    var new = Day(emoji: "default", date: "default", content: "default")
    
    var writtencontent : String? = nil // TextField 내용
    var seletedCondition : String = "❔" // segmentedcontrol로 선택된 condition값
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM"
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        dateFormatter2.dateFormat = "M월dd일"
        
        var today = Date.init()
        print(today)
        todayDate = dateFormatter1.string(from: today)
        print("todayDate ----------------\(todayDate)")
        
        new.date = todayDate
        SelectedDate.text = dateFormatter2.string(from: today)
        selectedDate = dateFormatter.string(from: today)
    }
    
    //datePicker 선택 시 실행
    @IBAction func SelectDate(_ sender: UIDatePicker){
        self.selectedDate = dateFormatter.string(from: sender.date)//DB에 들어갈 날짜용
        let selectedDate1 : String = dateFormatter1.string(from: sender.date) //DB에 들어갈 날짜용
        self.showDate = dateFormatter2.string(from: sender.date) //Label로 보여주기용

        new.date = selectedDate1 // DB에 저장(format1)
        SelectedDate.text = showDate // Label에 사용자가 선택한 날짜를 출력해줌
    }
    
    //segmentControl 작동 시 해당되는 emoji를 저장
    @IBAction func SelectCondition(_ sender: Any) {
        switch conditionSegment.selectedSegmentIndex {
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
            seletedCondition = "-"
        }
    }
    

    //저장버튼 클릭 시
    @IBAction func clickedSaveButton(_ sender: Any) {
     
        if let writtencontent = contentTextView.text {
            if writtencontent.isEmpty{ //textfield가 비었을 경우 alert 띄우기
                showAlert(style: .alert)
            }
            else { //사용자가 textfield에 입력을 하였을 경우
                self.new.content = writtencontent //DB에 값 저장
                self.new.emoji = self.seletedCondition //DB에 값 저장
                
                DBDiary.newDiary.addDiary(userID: currentUser, shortDate: selectedDate, new: new)
                self.dismiss(animated: true, completion: nil)} //모달창 내리기
            }
        }

    
    //alert 띄우기
    func showAlert(style : UIAlertController.Style){
        let alert = UIAlertController(title: "기록이 비었습니다", message: "그대로 저장하시겠습니까?", preferredStyle: style)
        let save = UIAlertAction(title: "저장", style: .default){(action) in
            //textfield가 비었는데도 저장할 경우
          
            self.new.content = ""//DB에 값 저장
            self.new.emoji = self.seletedCondition//DB에 값 저장
            
            DBDiary.newDiary.addDiary(userID: currentUser, shortDate: self.selectedDate, new: self.new)
            print("새 일기 작성 저장")
            self.dismiss(animated: true, completion: nil)
            
         
        } //모달창 내리기
        
       

        let cancel = UIAlertAction(title: "취소", style: .default){(action) in
            print("취소")}
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
 
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



extension AddDiaryTableController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        writtencontent = contentTextView.text
        
        print(writtencontent)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.contentTextView.resignFirstResponder()//키보드 숨기기
 
    }
}

