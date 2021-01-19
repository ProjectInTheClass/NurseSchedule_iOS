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

//private var days : [Day] = [
//    Day(emoji: "😊", date:"1", content: "ㅇㅇ이다"),
//    Day(emoji: "😊", date:"2", content: "ㅇㅇ이다"),
//    Day(emoji: "😊", date:"3", content: "ㅇㅇ이다")
//
//]


class DiaryController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell
        
//        let day = days[indexPath.row]
        let day = days
        
        cell.emojiLabel.text = emoji
        cell.dateLabel.text = date
        cell.contentLabel.text = content
        
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
     
    }
    
    @IBAction func unwindToDiary(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
