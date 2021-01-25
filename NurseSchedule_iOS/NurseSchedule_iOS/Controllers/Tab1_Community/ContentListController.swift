//
//  ContentListController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/21.
//

import UIKit
class ContentListController: UIViewController{
    
    var boardType : String? = nil
    var articleList : [Article] = []
    
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var contentListNavigation: UINavigationItem!
    @IBOutlet weak var boardInfoLabel: UILabel!
 
    @IBAction func unwindToContentList(segue : UIStoryboardSegue) {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from >>>>>> \(boardType)")
        
        if let boardType = boardType {
            articleList.removeAll()
            DBBoard.board.getArticleListIn(BoardType: boardType) { (article) in
                self.articleList.append(article)
                print("ContentList>>>>>>>\(self.articleList)")
                self.articleListTableView.reloadData()
            }
            // Do any additional setup after loading the view.
            contentListNavigation.title = boardType
            //articleListTableView.reloadData()
            
            //            for i in 0..<articleList.count {
            //
            //                DBBoard.board.getNumberOfCommentsInEachArticle(BoardType: boardType, articleID: articleList[i].articleID) { (numberOfComments) in
            //                    self.numberOfCommentsInEachArticle.append(String(numberOfComments))
            //                    print("bring success!!!!\(self.numberOfCommentsInEachArticle[i])")
            //                }
            //
            //            }
            if boardType == "공지사항" {
                self.navigationItem.setRightBarButton(nil, animated: true)
            }
            
            
            
        }
        
        boardInfoLabel.text = "info : 건전한 커뮤니티 조성을 위해 바른말, 고운말을 씁시다"
        
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        articleListTableView.estimatedRowHeight = 50
        articleListTableView.rowHeight = UITableView.automaticDimension
        //
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        articleListTableView.reloadData()
        //        articleListTableView.estimatedRowHeight = 100
        //loadTableView()
        articleListTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loadTableView()
        //articleListTableView.estimatedRowHeight = 100
        articleListTableView.rowHeight = UITableView.automaticDimension
        //articleListTableView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddForm" {
            let AddContentFormController = segue.destination as! AddContentFormController
            AddContentFormController.boardType = sender as? String
        }
        if let boardType = boardType {
            if segue.identifier == "articleDetail" {
                let DetailContentController = segue.destination as! DetailContentController
                DetailContentController.articleAllInfo = sender as? ArticleAllInfo
            }
        }
    }
    
    
    
    @IBAction func addArticleButtonTapped(_ sender: Any) {
        if let boardType = boardType {
            //articleList.removeAll()
            performSegue(withIdentifier: "showAddForm", sender: boardType)
        }
        
    }
    
    
}


extension ContentListController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        if let boardType = boardType {
            if boardType == "공지사항" {
                cell.numberOfComments.isHidden = true
            }
            DBBoard.board.getNumberOfCommentsInEachArticle(BoardType: boardType, articleID: articleList[indexPath.row].articleID) { (numberOfComments) in
                print("bring success!!!!\(String(numberOfComments))")
                cell.ContentNum.text = String(indexPath.row+1)
                cell.ContentDate.text = self.articleList[indexPath.row].date
                cell.ContentTitle.text = self.articleList[indexPath.row].title
                cell.ContentContent.text = self.articleList[indexPath.row].content
                cell.numberOfComments.text = "💬 " + String(numberOfComments)
            }
            
           // print("table안에서도 배열 만들어졌음!!!! \(numberOfCommentsInEachArticle)")
          //  print("indexPath.row >>>>>>>>> \(indexPath.row)")
           
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        //loadTableView()
        if let boardType = boardType {
            let articleAllInfo = ArticleAllInfo.init(boardType: boardType, articleInfo: articleList[indexPath.row])
            performSegue(withIdentifier: "articleDetail", sender: articleAllInfo)
        }
        
    }
    
}
