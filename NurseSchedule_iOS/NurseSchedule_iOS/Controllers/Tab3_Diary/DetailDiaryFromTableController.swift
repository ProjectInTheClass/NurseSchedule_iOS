//
//  DetailDiaryFromTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/25.
//

import UIKit
import Firebase
import RealmSwift

class DetailDiaryFromTableController: UIViewController {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var detailView: UIView!
    
    let img0 = UIImage(named: "0-love.png")
    let img1 = UIImage(named: "0-happy.png")
    let img2 = UIImage(named: "0-surprised.png")
    let img3 = UIImage(named: "0-crying.png")
    let img4 = UIImage(named: "0-devil.png")
    
  
    let realm = try! Realm()
    var month : String = ""
    var selectedDate : String = "" //tableView에서 받아온 날짜 저장
    
    
    //var detailInfoFromDay : Day? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let savedDiary = realm.objects(Diary.self)
        let selectedDiary = savedDiary.filter("date == '\(self.selectedDate)'")
        
        date.text = selectedDate
        
     
            switch selectedDiary[0].emoji {
            case 0:
                emojiImage.image = img0
            case 1:
                emojiImage.image = img1
            case 2:
                emojiImage.image = img2
            case 3:
                emojiImage.image = img3
            case 4:
                emojiImage.image = img4
            default:
                print("emojiImage")
            }
        
       
        content.text = selectedDiary[0].content

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButton2(_ sender: Any) {//tableView에서 detailView 들어갔을 때 삭제버튼
        showDeleteAlert()
    }
    
    @IBAction func modifyButton2(_ sender: Any) {//tableView에서 detailView 들어갔을 때 수정버튼
        let dayForSender = selectedDate
        let startView = "DetailDiaryFromTableController"
        let senderData = [startView : dayForSender]
        performSegue(withIdentifier: "editDiary", sender: senderData)
      
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //삭제하기 위한 Alert
    func showDeleteAlert() {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: " ", preferredStyle: UIAlertController.Style.alert)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel){(action) in print("아니요")}
        let deleteButton = UIAlertAction(title: "확인", style: .destructive){(action) in
      
            let savedDiary = self.realm.objects(Diary.self)
            let deleteDiary = savedDiary.filter("date == '\(self.selectedDate)'")
            try! self.realm.write({ self.realm.delete(deleteDiary) })//realm에서 삭제
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        self.present(alert, animated: true, completion: nil)
    }

    //수정할 때
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDiary" {
            print("addDiary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        } else if segue.identifier == "editDiary"{
            print("editDiary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            let modifyDiaryTableController = segue.destination as! ModifyDiaryTableController
            modifyDiaryTableController.startViewNDay = sender as! [String : String]
            
        }
    }
  

}
