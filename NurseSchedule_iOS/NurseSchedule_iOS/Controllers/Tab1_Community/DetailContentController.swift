//
//  DetailContentController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/22.
//

import UIKit

class DetailContentController: UIViewController {

    @IBOutlet weak var articleUser: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentUploadButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    @IBOutlet weak var editOrDeleteButton: UIBarButtonItem!
    
    var articleAllInfo : ArticleAllInfo? = nil
    
    
    var commentsList : [Comment] = []
    /*
    var articleID : String? = nil
    var boardType : String? = nil
    var selectedArticle : Article? = nil
    */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleUser.text = "👤익명"
        articleDate.text = articleAllInfo?.articleInfo.date
        articleTitle.text = articleAllInfo?.articleInfo.title
        articleContent.text = articleAllInfo?.articleInfo.content
    
        //글 작성자와 앱사용자가 다른 경우에 수정삭제 버튼 hidden
        guard let contentUser = articleAllInfo?.articleInfo.user else {   return  }
        if currentUser != contentUser {
            self.navigationItem.setRightBarButton(nil, animated: true)
        }
        
        commentsList.removeAll()
        guard let boardType = articleAllInfo?.boardType else { return }
        guard let articleID = articleAllInfo?.articleInfo.articleID else { return }
        DBBoard.board.getCommentsList(BoardType: boardType, articleID: articleID) { (comment) in
            self.commentsList.append(comment)
            print("commentLists get successful")
            self.commentTableView.reloadData()
        }
        //commentTableView.reloadData()
        
        
        DBBoard.board.getNumberOfCommentsInEachArticle(BoardType: boardType, articleID: articleID) { (numberOfComments) in

            self.numberOfCommentsLabel.text = "💬 "+String(numberOfComments)
        }


        
        
        commentTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        commentTextViewPlaceholderSetting()
        // Do any additional setup after loading the view.
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        //commentTableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentTableView.reloadData()
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //commentTableView.reloadData()
        //super.viewWillAppear(true)
    }
    
    @IBAction func EditOrDeleteButtonTapped(_ sender: Any) {
        showActionSheet()
    }
    
    func showActionSheet(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        
        let editButton = UIAlertAction(title: "수정하기", style: .default) {_ in
            self.performSegue(withIdentifier: "editContent", sender: self.articleAllInfo)
        }
        
        
        let deleteButton = UIAlertAction(title: "삭제하기", style: .destructive) {_ in
            self.announceForActionCompleted(actionType: ActionType.delete.typeStr)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(editButton)
        actionSheet.addAction(deleteButton)
        actionSheet.addAction(cancelButton)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func announceForActionCompleted(actionType: String) {
        if actionType == ActionType.delete.typeStr {
            let alert = UIAlertController(title: "삭제하시겠습니까?", message: "되돌이킬수없어요😭", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                guard let boardType = self.articleAllInfo?.boardType else { return }
                guard let articleID = self.articleAllInfo?.articleInfo.articleID else { return }
                DBBoard.board.deleteArticle(BoardType: boardType, articleID: articleID)
                self.performSegue(withIdentifier: "unwindToContentList", sender: nil)
          
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContent" {
            let EditContentFormController = segue.destination as! EditContentFormController
            EditContentFormController.forEditing = sender as? ArticleAllInfo
        }
    }
    
    @IBAction func commentUploadButtomTapped(_ sender: Any) {
        guard let boardType = articleAllInfo?.boardType else { return }
        guard let articleID = articleAllInfo?.articleInfo.articleID else { return }
        let comment = commentTextView.text!
        DBBoard.board.addComment(BoardType: boardType, articleID: articleID, comment: comment)
        commentTextViewPlaceholderSetting()
        textViewDidBeginEditing(commentTextView)
        commentTableView.reloadData()
    }

}

extension DetailContentController : UITextViewDelegate {
    func commentTextViewPlaceholderSetting() {
        commentTextView.text = "댓글을 입력하세요"
        commentTextView.textColor = UIColor.lightGray
            
        }
        
        // TextView Place Holder
        func textViewDidBeginEditing(_ textView: UITextView) {
            if commentTextView.textColor == UIColor.lightGray {
                commentTextView.text = nil
                commentTextView.textColor = UIColor.black
            }
            
        }
        // TextView Place Holder
        func textViewDidEndEditing(_ textView: UITextView) {
            if commentTextView.text.isEmpty {
                commentTextViewPlaceholderSetting()
            }
        }
}

extension DetailContentController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        cell.commentContent.text = commentsList[indexPath.row].content
        cell.commentDate.text = commentsList[indexPath.row].date
        cell.commentUser.text = "👤익명"
        //cell.commentUser.text = commentsList[indexPath.row].writer
        return cell
    }
    
    
    
    
    
    // 댓글 삭제
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if commentsList[indexPath.row].writer == currentUser {
            return .delete
        }
        return .none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let boardType = articleAllInfo?.boardType else { return }
            guard let articleID = articleAllInfo?.articleInfo.articleID else { return }
            DBBoard.board.deleteComment(BoardType:boardType , articleID: articleID, commentID: commentsList[indexPath.row].commentID)
            commentsList.remove(at: indexPath.row)
            commentTableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
}
