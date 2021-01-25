//
//  ModifyDiaryTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/24.
//

import UIKit

class ModifyDiaryTableController: UITableViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var conditionSegController: UISegmentedControl!
    @IBOutlet weak var ModifytextView: UITextView!
    
    var change : Day? = nil
    
    var writtencontent : String? = nil // TextField 내용
    var seletedCondition : String = " " // segmentedcontrol로 선택된 condition값
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
     
    }
    
    func showData() {
//        DBDiary.newDiary.getDayDiary(userID: currentUser, date: change?.date, completion: <#T##(Day?) -> Void#>)
//         datepicker.date
//         conditionSegController.selectedSegmentIndex
//         ModifytextView.text
    }

    
    
//    DBDiary.newDiary.getDiary(userID: currentUser, shortDate: self.getDiaryDate, completion: { result in //result에 Day(emoji: "😢", date: "2021-01-03", content: "getDiary")형식으로 저장되어있음
//        self.bringdays.append(result)
//        print("app delegate \(result)")
//        self.tableView.reloadData()
//    })


}
//
//extension ModifyDiaryTableController : UITextViewDelegate{
//    func textViewDidChange(_ textView: UITextView) {
//        DBDiary.newDiary.modifyDiary(userID: currentUser, shortDate: shortDate, new: <#T##Day#>)
//    }
//}
