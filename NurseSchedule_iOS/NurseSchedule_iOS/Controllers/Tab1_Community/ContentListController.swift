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
    var filteredArticleList : [Article]!
    var outputArticleList = [Article]()
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var contentListNavigation: UINavigationItem!
    @IBOutlet weak var boardInfoLabel: UILabel!
 
    @IBAction func unwindToContentList(segue : UIStoryboardSegue) {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from >>>>>> \(boardType)")
        
        outputArticleList = articleList
        
        
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
        
        searchbar.delegate = self
        searchbar.placeholder = "게시글을 검색하세요."
        
        articleListTableView.keyboardDismissMode = .onDrag
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        outputArticleList = articleList
        articleListTableView.reloadData()
        //        articleListTableView.estimatedRowHeight = 100
        //loadTableView()
        articleListTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loadTableView()
        //articleListTableView.estimatedRowHeight = 100
        outputArticleList = articleList
        articleListTableView.rowHeight = UITableView.automaticDimension
        articleListTableView.reloadData()
        
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
        return outputArticleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        if let boardType = boardType {
            if boardType == "공지사항" {
                cell.numberOfComments.isHidden = true
            }
            DBBoard.board.getNumberOfCommentsInEachArticle(BoardType: boardType, articleID: outputArticleList[indexPath.row].articleID) { (numberOfComments) in
                print("bring success!!!!\(String(numberOfComments))")
                cell.ContentNum.text = String(indexPath.row+1)
                cell.ContentDate.text = self.outputArticleList[indexPath.row].date
                cell.ContentTitle.text = self.outputArticleList[indexPath.row].title
                cell.ContentContent.text = self.outputArticleList[indexPath.row].content
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
            let articleAllInfo = ArticleAllInfo.init(boardType: boardType, articleInfo: outputArticleList[indexPath.row])
            performSegue(withIdentifier: "articleDetail", sender: articleAllInfo)
        }
        
    }
    
}

extension ContentListController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            filteredArticleList = articleList
        } else {
            //filteredTermsBySearchbar = []
            // termsList = allData
            filteredArticleList = articleList.filter({
                $0.content.contains(searchText) || $0.title.contains(searchText)
            })
            //termsList = filteredTerms
        }
        outputArticleList = filteredArticleList
        //termsList = filteredTerms
        self.articleListTableView.reloadData()
    }
    
}

