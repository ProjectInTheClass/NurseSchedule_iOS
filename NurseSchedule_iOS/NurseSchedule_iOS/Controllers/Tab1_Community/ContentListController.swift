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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from >>>>>> \(boardType)")
        if let boardType = boardType {
            DBBoard.board.getArticleListIn(BoardType: boardType) { (article) in
                self.articleList.append(article)
                print("ContentList>>>>>>>\(self.articleList)")
                self.articleListTableView.reloadData()
            }
            // Do any additional setup after loading the view.
            contentListNavigation.title = boardType
            articleListTableView.reloadData()
        }
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        articleListTableView.estimatedRowHeight = 50
        articleListTableView.rowHeight = UITableView.automaticDimension
        //
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        articleListTableView.reloadData()
        //        articleListTableView.estimatedRowHeight = 100
        articleListTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        articleListTableView.estimatedRowHeight = 100
        articleListTableView.rowHeight = UITableView.automaticDimension
        articleListTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddForm" {
            let InputTableViewController = segue.destination as! InputTableViewController
            InputTableViewController.boardType = sender as? String
        }
        
        if segue.identifier == "articleDetail" {
            let DetailContentController = segue.destination as! DetailContentController
            DetailContentController.selectedArticle = sender as? Article
        }
    }
    
    
    
    @IBAction func addArticleButtonTapped(_ sender: Any) {
        if let boardType = boardType {
            performSegue(withIdentifier: "showAddForm", sender: boardType)
        }
        
    }
    
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
}


extension ContentListController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        cell.ContentNum.text = String(indexPath.row+1)
        cell.ContentDate.text = articleList[indexPath.row].date
        cell.ContentTitle.text = articleList[indexPath.row].title
        cell.ContentContent.text = articleList[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        performSegue(withIdentifier: "articleDetail", sender: articleList[indexPath.row])
    }
    
}
