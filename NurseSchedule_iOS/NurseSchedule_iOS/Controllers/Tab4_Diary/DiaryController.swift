//
//  DiaryController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit



class DiaryController: UIViewController {
    
    let currentUser = Login.init().googleLogin()
    
    var bringdays : [Day] = []

    var getDiaryDate : String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.reloadData()
        // Do any additional setup after loading the view.
        // 다이어리 목록을 디비에서 불러옴
        let dateFormatter : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 0(월단위)
        dateFormatter.dateFormat = "yyyy-MM"
        self.getDiaryDate = dateFormatter.string(from: Date.init())
        self.bringdays.removeAll()
        DBDiary.newDiary.getDiary(userID: currentUser, shortDate: self.getDiaryDate, completion: { result in //result에 Day(emoji: "😢", date: "2021-01-03", content: "getDiary")형식으로 저장되어있음
            self.bringdays.append(result)
            print("app delegate \(result)")
            self.tableView.reloadData()
        })
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            let detailDiaryFromTableController = segue.destination as! DetailDiaryFromTableController
            detailDiaryFromTableController.detailInfoFromDay = sender as? Day
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
