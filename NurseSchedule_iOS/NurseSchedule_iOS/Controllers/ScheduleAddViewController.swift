//
//  ScheduleAddViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/14.
//

import UIKit

enum WorkType {
    case DAY
    case EVENING
    case NIGHT
    case OFF
}

struct NewMemo {
    var date : String
    var workType : WorkType
    var memo : String
}

class ScheduleAddViewController: UIViewController{


    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var workTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var memoTextField: UITextField!
    
    var newMemo = NewMemo(date: "default_date", workType: .DAY, memo: "default_memo_content")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //memoTextField.delegate = self
       
        // Do any additional setup after loading the view.
        if let date = date.text {
            newMemo.date = date
        }
    }  
    
    // 메모에 들어가는 최대 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (memoTextField.text?.count ?? 0 > maxLength) {
            memoTextField.deleteBackward()
        }
    }

    
    // memoTextField에 글자써질때마다 글자수 체크
    @IBAction func textDidChanged(_ sender: Any) {
        checkMaxLength(textField: memoTextField, maxLength: 30)
    }
    
    // memoTextField의 글자가 모두 쳐졌을 때
    @IBAction func textDidEnd(_ sender: Any) {
        if let memoContent = memoTextField.text {
            newMemo.memo = memoContent
        }
    }
    
    @IBAction func workTypeSeleted(_ sender: UISegmentedControl) {
        if workTypeSegmentedControl.selectedSegmentIndex == 0 {
            newMemo.workType = .DAY
        } else if workTypeSegmentedControl.selectedSegmentIndex == 1 {
            newMemo.workType = .EVENING
        } else if workTypeSegmentedControl.selectedSegmentIndex == 2 {
            newMemo.workType = .NIGHT
        } else {
            newMemo.workType = .OFF
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addButtonTapped(_ sender: Any) {
        print(newMemo)
        
    }
    
}

