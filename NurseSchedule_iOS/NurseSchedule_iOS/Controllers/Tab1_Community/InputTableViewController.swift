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
    
    var boardType : String? = nil
    var newArticle = Article(articleID : "default", title: "default", date: "default", content: "default", user: "default")
    
    
    var StoredTitleData : String? = nil
    var StoredContentData : String? = nil
    
    
    
    @IBAction func DoneTitle(_ sender: Any) {
        StoredTitleData = inputTitle.text
        print(StoredTitleData)
    }
    
    @IBAction func cancleButtonTapped(_ sender: Any) {
    
        performSegue(withIdentifier: "unwindToContentList", sender: nil)
    }
    @IBAction func SaveButton(_ sender: Any) {
        
        if let StoredTitleData = inputTitle.text, let StoredContentData = inputContents.text {
            if StoredTitleData.isEmpty || StoredContentData.isEmpty {
                showAlert()
            } else {
                
                newArticle.user = currentUser
                newArticle.content = self.StoredContentData!
                newArticle.title = self.StoredTitleData!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                newArticle.date = dateFormatter.string(from: Date.init())
                
                
                print("add되기전에 게시판 이름 제대로야? \(boardType)")
                if let boardType = boardType {
                    DBBoard.board.addContent(BoardType: boardType, DataType: "contentList", new: newArticle)
                }
                
               
                performSegue(withIdentifier: "unwindToContentList", sender: nil)
                
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
    
    // 내용 텍스트 placeholer 추가
    
    
//    textView.text = "Placeholder"
//    textView.textColor = UIColor.lightGray
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Placeholder"
//            textView.textColor = UIColor.lightGray
//        }
//    }

}


extension InputTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        StoredContentData = inputContents.text
        print(StoredContentData)
      
    }
}
