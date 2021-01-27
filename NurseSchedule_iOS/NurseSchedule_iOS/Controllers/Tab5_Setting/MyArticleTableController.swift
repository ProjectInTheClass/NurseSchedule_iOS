//
//  MyArticleTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/27.
//

import UIKit

class MyArticleTableController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyArticleCell", for: indexPath)

        // Configure the cell...

        return cell
    }

  
  


}
