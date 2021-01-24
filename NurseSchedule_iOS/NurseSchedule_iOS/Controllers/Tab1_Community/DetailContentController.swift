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
    
    var forCommentSavingInfo : ForCommentSavingInfo? = nil
    
    
    var commentsList : [Comment] = []
    /*
    var articleID : String? = nil
    var boardType : String? = nil
    var selectedArticle : Article? = nil
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleUser.text = "👤익명"
        articleDate.text = forCommentSavingInfo?.newComment.date
        articleTitle.text = forCommentSavingInfo?.newComment.title
        articleContent.text = forCommentSavingInfo?.newComment.content
    
        
        commentTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        commentTextViewPlaceholderSetting()
        // Do any additional setup after loading the view.
        guard let boardType = forCommentSavingInfo?.boardType else { return }
        guard let articleID = forCommentSavingInfo?.newComment.articleID else { return }
        DBBoard.board.getCommentsList(BoardType: boardType, articleID: articleID) { (comment) in
            self.commentsList.append(comment)
            print("commentLists get successful")
            self.commentTableView.reloadData()
        }
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentTableView.reloadData()
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commentTableView.reloadData()
        super.viewWillAppear(true)
    }
    
    @IBAction func actionButton(_ sender: Any) {
        showActionSheet()
    }
    
    
    func showActionSheet(){
        let actionSheet = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertController.Style.actionSheet)
        
        let editButton = UIAlertAction(title: "수정하기", style: .default)
        let deleteButton = UIAlertAction(title: "삭제하기", style: .default)
        
        actionSheet.addAction(editButton)
        actionSheet.addAction(deleteButton)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func commentUploadButtomTapped(_ sender: Any) {
        guard let boardType = forCommentSavingInfo?.boardType else { return }
        guard let articleID = forCommentSavingInfo?.newComment.articleID else { return }
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
}
