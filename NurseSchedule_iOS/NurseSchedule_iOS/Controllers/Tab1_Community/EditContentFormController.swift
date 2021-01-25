//
//  EditContentFormController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/24.
//

import UIKit

class EditContentFormController: UITableViewController {

    var forEditing : ArticleAllInfo? = nil
    
   
    @IBOutlet weak var articleTitleTextField: UITextField!
    
    @IBOutlet weak var articleContentTextView: UITextView!
    
    var newArticle = Article(articleID : "default", title: "default", date: "default", content: "default", user: "default")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTitleTextField.text = forEditing?.articleInfo.title
        articleContentTextView.text = forEditing?.articleInfo.content
        
        guard let articleID = forEditing?.articleInfo.articleID else {return}
        guard let date = forEditing?.articleInfo.date else {return}
        guard let title = forEditing?.articleInfo.title else {return}
        guard let content = forEditing?.articleInfo.content else {return}
        guard let user = forEditing?.articleInfo.user else {return}
        newArticle.articleID = articleID
        newArticle.date = date
        newArticle.title = title
        newArticle.content = content
        newArticle.user = user
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancleButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToContentList", sender: nil)
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        
        if let StoredTitleData = articleTitleTextField.text, let StoredContentData = articleContentTextView.text {
            if StoredTitleData.isEmpty || StoredContentData.isEmpty {
                showAlert()
            } else {
                //newArticle.user = currentUser
                newArticle.content = StoredContentData
                newArticle.title = StoredTitleData
                //let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "yyyy-MM-dd"
                
                //newArticle.date = dateFormatter.string(from: Date.init())
                
                
                print("add되기전에 게시판 이름 제대로야? \(forEditing?.boardType)")
                if let boardType = forEditing?.boardType {
                    guard let articleID = forEditing?.articleInfo.articleID else {return}
                    DBBoard.board.editContent(BoardType: boardType, update: newArticle, articleID : articleID)
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
