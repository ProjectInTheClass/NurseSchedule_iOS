//
//  AddContentFormController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/24.
//

import UIKit

class AddContentFormController : UITableViewController {
    
  
    @IBOutlet weak var articleTitleTextField: UITextField!
    @IBOutlet weak var articleContentTextView: UITextView!
    
    var boardType : String? = nil
    var newArticle = Article(articleID : "default", title: "default", date: "default", content: "default", user: "default")
    
    let placeholderText = "내용을 입력하세요"
//
//    @IBAction func unwindToEditContent(segue : UIStoryboardSegue) {}
//
//
    
    @IBAction func cancleButtonTapped(_ sender: Any) {
    
        performSegue(withIdentifier: "unwindToContentList", sender: nil)
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        
        if let StoredTitleData = articleTitleTextField.text, let StoredContentData = articleContentTextView.text {
            if StoredTitleData.isEmpty || StoredContentData == placeholderText {
                showAlert()
            } else {
                newArticle.user = currentUser
                newArticle.content = StoredContentData
                newArticle.title = StoredTitleData
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
        
        let alert = UIAlertController(title: "작성이 완료되지 않았어요😂", message: "제목과 내용을 확인해주세요!", preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okayButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        articleContentTextView.delegate = self
        articleContentTextViewPlaceholderSetting()
        
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

extension AddContentFormController: UITextViewDelegate {
    func articleContentTextViewPlaceholderSetting() {
        articleContentTextView.text = placeholderText
        articleContentTextView.textColor = UIColor.lightGray
            
        }
        
        // TextView Place Holder
        func textViewDidBeginEditing(_ textView: UITextView) {
            if articleContentTextView.textColor == UIColor.lightGray {
                articleContentTextView.text = nil
                articleContentTextView.textColor = UIColor.black
            }
            
        }
        // TextView Place Holder
        func textViewDidEndEditing(_ textView: UITextView) {
            if articleContentTextView.text.isEmpty {
                articleContentTextViewPlaceholderSetting()
            }
        }
}
