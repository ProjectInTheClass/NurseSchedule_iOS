//
//  AddDiaryController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/18.
//

import UIKit

class AddDiaryController: UITableViewController {

    @IBOutlet weak var selected: UILabel!
    @IBOutlet weak var conditionSegment: UISegmentedControl!
    @IBOutlet weak var diaryContent: UITextField!
    
    var writtenContent : String? = nil
    var seletedCondition : String = " " // segmentedcontrol로 선택된 condition값
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selected.text = " 오늘 "
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    //datePicker 선택 시 실행
    @IBAction func SelectDate(_ sender: UIDatePicker){
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //DB에 들어갈 날짜용
        
        let dateFormatter2 : DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "M월dd일"
        
        let selectedDate : String = dateFormatter.string(from: sender.date)//DB에 들어갈 날짜용
        let showDate : String = dateFormatter2.string(from: sender.date) //보여주기용
        
        self.selected.text = showDate
        
        
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
    
    
    @IBAction func wroteDiary(_ sender: Any) {
        self.writtenContent = diaryContent.text!
    }
    
    
    @IBAction func clickedSaveButton(_ sender: Any) {
      

       
            

       
        if let writtenContent = diaryContent.text {
            if writtenContent.isEmpty{
                showAlert(style: .alert)
            }
            else {  self.dismiss(animated: true, completion: nil)}
        }
      
         
        }
    
    func showAlert(style : UIAlertController.Style){
        let alert = UIAlertController(title: "기록이 비었습니다", message: "그대로 저장하시겠습니까?", preferredStyle: style)
        let save = UIAlertAction(title: "저장", style: .default){(action) in         self.dismiss(animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "취소", style: .default){(action) in print("취소")}
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    }
    
    

