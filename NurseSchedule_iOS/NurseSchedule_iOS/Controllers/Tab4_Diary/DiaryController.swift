//
//  DiaryController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit

struct Day {
    var emoji : String
    var date : String
    var content : String
}


class DiaryController: UIViewController {
    
    let currentUser = Login.init().googleLogin()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    
    
    @IBAction func unwindToDiary(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
   
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupDiary" {
            let DiaryDetailViewController = segue.destination as! DiaryDetailViewController
            DiaryDetailViewController.detailInfoFromDay = sender as? Day
        }
     }
    
}

extension DiaryController :UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return days.count
        //  return DBDiary.newDiary.diarycellCount
        print("controller bringdays.count -> \(bringdays.count)")
        return bringdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell
        
        //let bringday = bringdays
        
        print("bringday \(bringdays)")
        
        cell.emojiLabel.text = bringdays[indexPath.row].emoji
        cell.dateLabel.text = bringdays[indexPath.row].date
        cell.contentLabel.text = bringdays[indexPath.row].content
        
        
        return cell
    }
    
}

extension DiaryController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        performSegue(withIdentifier: "popupDiary", sender: bringdays[indexPath.row])
    }
    
}
