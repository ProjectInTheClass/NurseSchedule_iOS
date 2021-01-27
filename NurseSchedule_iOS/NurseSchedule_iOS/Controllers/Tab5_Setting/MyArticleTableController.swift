//
//  MyArticleTableController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/27.
//

import UIKit

class MyArticleTableController: UITableViewController {

    
    
    var myContentList : [myContentInfo] = []
    
    @IBOutlet var tableview: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        DBSetting.setting.getMyArticleList { (myContent) in
            self.myContentList.append(myContent)
            print("‼️‼️‼️‼️‼️\(self.myContentList)")
            self.tableview.reloadData()
        }
        

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myContentList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyArticleCell", for: indexPath) as! MyArticleCell

        cell.articleDate.text = myContentList[indexPath.row].date
        cell.articleTitle.text = myContentList[indexPath.row].title
        cell.boardType.text = myContentList[indexPath.row].boardType

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let senderForDetailView = myContentList[indexPath.row].self
        performSegue(withIdentifier: "showMyContentDetail", sender: senderForDetailView)
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMyContentDetail" {
            let DetailContent_inSettingController = segue.destination as! DetailContent_inSettingController
            DetailContent_inSettingController.getMyContentInfo = sender as? myContentInfo
        }
    }

}
