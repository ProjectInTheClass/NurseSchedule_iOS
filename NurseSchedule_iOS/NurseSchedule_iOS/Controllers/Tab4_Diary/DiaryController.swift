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

private var days : [Day] = [
    Day(emoji: "😊", date:"1", content: "ㅇㅇ이다"),
    Day(emoji: "😊", date:"2", content: "ㅇㅇ이다"),
    Day(emoji: "😊", date:"3", content: "ㅇㅇ이다")

]


class DiaryController: UIViewController, UITableViewDataSource {
    
   
    var getDiaryDate : String = ""
    let currentUser = Login.init().googleLogin()
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
        return DBDiary.newDiary.diarycellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell
        
        let day = days[indexPath.row]
        
        cell.emojiLabel.text = day.emoji
        cell.dateLabel.text = day.date
        cell.contentLabel.text = day.content
        
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let dateFormatter : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 0(월단위)
        dateFormatter.dateFormat = "yyyy-MM"
        getDiaryDate = dateFormatter.string(from: Date.init())
        
        DBDiary.newDiary.getDiary(userID: currentUser, shortDate: getDiaryDate, completion: {
            result in
                print("AddDiaryTableController - \(result)")
        })
     
        
      
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
