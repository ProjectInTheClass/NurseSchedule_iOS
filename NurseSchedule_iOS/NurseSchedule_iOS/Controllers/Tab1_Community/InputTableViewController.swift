//
//  InputTableViewController.swift
//  NurseSchedule_iOS
//
//  Created by 박흥기 on 2021/01/21.
//

import UIKit

class InputTableViewController: UITableViewController {
    
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputContents: UITextView!
    
    var BoardType : String = "임시게시판"
    let currentUser = Login.init().googleLogin()
    var newArticle = Article(title: "default", date: "default", content: "default", user: "default")
    
    
    var StoredTitleData : String? = nil
    var StoredContentData : String? = nil
    
    
    
    @IBAction func DoneTitle(_ sender: Any) {
        StoredTitleData = inputTitle.text
        print(StoredTitleData)
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        
        if let StoredTitleData = inputTitle.text, let StoredContentData = inputContents.text {
            if StoredTitleData.isEmpty || StoredContentData.isEmpty {
                showAlert()
            } else {
                
                newArticle.user = currentUser
                newArticle.content = self.StoredContentData!
                newArticle.title = self.StoredTitleData!
                newArticle.date = "\(Date.init())"
                
                
                DBBoard.board.addContent(BoardType: self.BoardType, DataType: "contentList", new: newArticle)
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
            
            
        }
    
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "비었습니다", message: "입력해주세요", preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        inputContents.delegate = self
    }
    
    // MARK: - Table view data source
    
    

}


extension InputTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        StoredContentData = inputContents.text
        print(StoredContentData)
      
    }
}
