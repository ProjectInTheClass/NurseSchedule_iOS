//
//  DetailDiaryFromTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/25.
//

import UIKit
import Firebase

class DetailDiaryFromTableController: UIViewController {
    
//    static let detailDiaryFromTableController = DetailDiaryFromTableController()
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var content: UITextView!
    
    @IBOutlet weak var detailView: UIView!
    
    let img0 = UIImage(named: "0-love.png")
    let img1 = UIImage(named: "0-happy.png")
    let img2 = UIImage(named: "0-surprised.png")
    let img3 = UIImage(named: "0-crying.png")
    let img4 = UIImage(named: "0-devil.png")
    
    let currentUser = Auth.auth().currentUser?.uid
    var detailInfoFromDay : Day? = nil
    
    var shortDate : String = ""
    var editdate : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.text = detailInfoFromDay?.date
        
        if let emojinum = detailInfoFromDay?.emoji{
            switch emojinum {
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
        }
        content.text = detailInfoFromDay?.content

        // Do any additional setup after loading the view.
        self.editdate = detailInfoFromDay!.date
    }
    
    @IBAction func deleteButton2(_ sender: Any) {//tableView에서 detailView 들어갔을 때 삭제버튼
        showDeleteAlert()
    }
    
    @IBAction func modifyButton2(_ sender: Any) {//tableView에서 detailView 들어갔을 때 수정버튼
        let dayForSender = detailInfoFromDay
        let startView = "DetailDiaryFromTableController"
        let senderData = [startView : dayForSender]
        performSegue(withIdentifier: "editDiary", sender: senderData)
        //AddDiaryTableController.addDiaryController.modifyDiary()
        //detailView.isHidden = true
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showDeleteAlert() {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: " ", preferredStyle: UIAlertController.Style.alert)
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel){(action) in
            print("아니요")}
        let deleteButton = UIAlertAction(title: "확인", style: .destructive){(action) in
      
            self.shortDate =  String(self.date.text!.prefix(7))
            
//            DBDiary.newDiary.deleteDiary(userID: self.currentUser!, shortDate: self.shortDate, date: self.date.text!)
//            
            
     
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDiary" {
            print("addDiary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

        } else if segue.identifier == "editDiary"{
            print("editDiary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            let modifyDiaryTableController = segue.destination as! ModifyDiaryTableController
            modifyDiaryTableController.startViewNDay = sender as? [String : Day]
            
        }
    }
  

}
