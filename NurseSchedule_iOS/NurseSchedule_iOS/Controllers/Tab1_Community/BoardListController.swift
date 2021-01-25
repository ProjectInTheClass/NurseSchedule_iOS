//
//  BoardListController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/24.
//

import UIKit

class BoardListController: UIViewController {

    
    @IBOutlet weak var boardListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(boardList)
        boardListTableView.delegate = self
        boardListTableView.dataSource = self
        boardListTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleList" {
            let ContentListController = segue.destination as! ContentListController
            ContentListController.boardType = sender as? String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
    }

}


extension BoardListController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("boardList.count\(boardList.count)")
        return boardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardListCell", for: indexPath) as! boardListCell
        cell.accessoryType = .disclosureIndicator
        cell.boardList.text = boardList[indexPath.row]
        
        //print("boardList[index] \(boardList[indexPath.row])")
        //print("cell text \(cell.textLabel?.text)")
        //tableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)

        performSegue(withIdentifier: "articleList", sender: boardList[indexPath.row])
    }
}


extension BoardListController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if(searchText == "") {
//            filteredTermsBySearchbar = termsList
//        } else {
//
//            filteredTermsBySearchbar = termsList.filter({
//                $0.englishTerm.lowercased().contains(searchText.lowercased())
//            })
//
//        }
//        outputDataForTableView = filteredTermsBySearchbar
//
        self.boardListTableView.reloadData()
    }
    
}

