//
//  DetailContent_inSettingController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/27.
//


import UIKit

class DetailContent_inSettingController: UIViewController {

    @IBOutlet weak var articleUser: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentUploadButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    @IBOutlet weak var editOrDeleteButton: UIBarButtonItem!
    
    var getMyContentInfo : myContentInfo? = nil
    var articleAllInfo : Article? = nil
    
    
    var commentsList : [Comment] = []
    /*
    var articleID : String? = nil
    var boardType : String? = nil
    var selectedArticle : Article? = nil
    */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let boardType = getMyContentInfo?.boardType else { return }
        guard let articleNum = getMyContentInfo?.articleNum else { return }
        
        
        print("✅\(boardType)")
        print("✅\(articleNum)")
        
        
        
        DBBoard.board.getArticleInfoIn(BoardType: boardType, articleNum: articleNum) { (article) in
            self.articleAllInfo = article
            print("articleAllInfo‼️‼️‼️‼️‼️‼️ \(self.articleAllInfo)")
            self.articleUser.text = "👤익명"
            self.articleDate.text = self.articleAllInfo?.date
            self.articleTitle.text = self.articleAllInfo?.title
            self.articleContent.text = self.articleAllInfo?.content
            
            DBBoard.board.getNumberOfCommentsInEachArticle(BoardType: boardType, articleID: articleNum) { (numberOfComments) in

                self.numberOfCommentsLabel.text = "💬 "+String(numberOfComments)
            }
            
            //self.commentsList = self.readDB(boardType: boardType, articleNum: articleNum)
        
        }
        
        
        
        //글 작성자와 앱사용자가 다른 경우에 수정삭제 버튼 hidden
        guard let contentUser = articleAllInfo?.user else {   return  }
        if currentUser != contentUser {
            self.navigationItem.setRightBarButton(nil, animated: true)
        }
        
//        commentsList.removeAll()
//
//        DBBoard.board.getCommentsList(BoardType: boardType, articleID: articleNum) { (comment) in
//            print("☀️\(boardType)")
//            print(articleNum)
//            self.commentsList.append(comment)
//            print("commentLists get successful")
//            self.commentTableView.reloadData()
//        }
        //commentTableView.reloadData()
        
        if boardType == "공지사항" {
            numberOfCommentsLabel.isHidden = true
        }
        
        commentTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        commentTextViewPlaceholderSetting()
        // Do any additional setup after loading the view.
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        //commentTableView.reloadData()
        
        
        //keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))

    }
    
    
    func readDB(boardType : String, articleNum : String) -> [Comment] {
        commentsList.removeAll()
        
        DBBoard.board.getCommentsList(BoardType: boardType, articleID: articleNum) { (comment) in
            print("☀️\(boardType)")
            print(articleNum)
            self.commentsList.append(comment)
            print("commentLists get successful")
            self.commentTableView.reloadData()
        }
        
        return commentsList
    }
    
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
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
                guard let boardType = self.getMyContentInfo?.boardType else { return }
                guard let articleNum = self.getMyContentInfo?.articleNum else { return }
                DBBoard.board.deleteArticle(BoardType: boardType, articleID: articleNum)
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
        guard let boardType = getMyContentInfo?.boardType else { return }
        guard let articleNum = getMyContentInfo?.articleNum else { return }
        let comment = commentTextView.text!
        DBBoard.board.addComment(BoardType: boardType, articleID: articleNum, comment: comment)
        commentTextViewPlaceholderSetting()
        textViewDidBeginEditing(commentTextView)
        commentTableView.reloadData()
    }

}

extension DetailContent_inSettingController : UITextViewDelegate {
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
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -250 // Move view 150 points upward
        
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.commentTextView.inputAccessoryView = toolBar//5
    }
    
}

extension DetailContent_inSettingController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentsList = readDB(boardType: getMyContentInfo!.boardType, articleNum: getMyContentInfo!.articleNum)
        if commentsList != nil {
            print("data !!!!!!!!!!!!!!!!!!!!!!!!!!")
        } else {
            print("no data !!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }
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
        if commentsList[indexPath.row].writer == currentUser! {
            return .delete
        }
        return .none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "삭제하시겠습니까?", message: "되돌이킬수없어요😭", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let okAction = UIAlertAction(title: "확인", style: .destructive) { [self] _ in
                guard let boardType = self.getMyContentInfo?.boardType else { return }
                guard let articleNum = self.getMyContentInfo?.articleNum else { return }
                DBBoard.board.deleteComment(BoardType:boardType , articleID: articleNum, commentID: self.commentsList[indexPath.row].commentID)
                self.commentsList.remove(at: indexPath.row)
                self.commentTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
            
            
        }
    }
    
}
