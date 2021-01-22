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
            }
            // Do any additional setup after loading the view.
            contentListNavigation.title = boardType
            articleListTableView.reloadData()
        }
        
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        articleListTableView.reloadData()
    }

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        showAddForm
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 */
 
 
 
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}


extension ContentListController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        cell.ContentNum.text = String(indexPath.row)
        cell.ContentDate.text = articleList[indexPath.row].date
        cell.ContentTitle.text = articleList[indexPath.row].title
        cell.ContentContent.text = articleList[indexPath.row].content
        return cell
    }
    
}
