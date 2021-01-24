//
//  DiaryDetailViewController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/18.
//

import UIKit



class DiaryDetailViewController: UIViewController {
    

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var content: UITextView!
    
    
    let currentUser = Login.init().googleLogin()
    var detailInfoFromDay : Day? = nil
    
    var shortDate : String = ""
    
    
    

   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        date.text = detailInfoFromDay?.date
        emoji.text = detailInfoFromDay?.emoji
        content.text = detailInfoFromDay?.content
        // Do any additional setup after loading the view.
       
        
    }
    @IBAction func deleteButton2(_ sender: Any) {//tableView에서 detailView 들어갔을 때 삭제버튼
        showDeleteAlert()
    }
    @IBAction func deleteButton(_ sender: Any) {//Calendar에서 detailView 들어갔을 때 삭제버튼
       showDeleteAlert()
        
    }
    
    @IBAction func modifyButton2(_ sender: Any) {//tableView에서 detailView 들어갔을 때 수정버튼
        performSegue(withIdentifier: "editDiary", sender: detailInfoFromDay)
        AddDiaryTableController.addDiaryController.modifyDiary()
        print(detailInfoFromDay)
        
    }
    @IBAction func modifyButton(_ sender: Any) {//Calendar에서 detailView 들어갔을 때 수정버튼
        performSegue(withIdentifier: "editDiary", sender: detailInfoFromDay)
        AddDiaryTableController.addDiaryController.modifyDiary()
        
    }
    
    
    func showDeleteAlert() {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: " ", preferredStyle: UIAlertController.Style.alert)
        let deleteButton = UIAlertAction(title: "네", style: .default){(action) in
      
            self.shortDate =  String(self.date.text!.prefix(7))
            
            DBDiary.newDiary.deleteDiary(userID: self.currentUser, shortDate: self.shortDate, date: self.date.text!)
        }
        let cancelButton = UIAlertAction(title: "아니요", style: .default){(action) in
            print("아니요")}
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        print("alert!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? AddDiaryTableController else {
            return
        }
        if segue.identifier == "addDiary" {
            print("addDiary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
//            nextViewController.ContentTextView = nil
//            nextViewController.SelectedDate = nil
//            nextViewController.conditionSegment = nil
            
        } else if segue.identifier == "editDiary"{
            print("editDiary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
//            nextViewController.ContentTF.text = detailInfoFromDay?.content
//            nextViewController.SelectedDate.text = detailInfoFromDay?.date
          //  nextViewController.SelectCondition(Any).self= detailInfoFromDay?.emoji
            
        }
    }
  

}
