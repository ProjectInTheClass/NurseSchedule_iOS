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
    
    let img0 = UIImage(named: "0-love.png")
    let img1 = UIImage(named: "0-happy.png")
    let img2 = UIImage(named: "0-surprised.png")
    let img3 = UIImage(named: "0-crying.png")
    let img4 = UIImage(named: "0-devil.png")
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView.reloadData()
        // Do any additional setup after loading the view.
        // 다이어리 목록을 디비에서 불러옴
        let dateFormatter : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 0(월단위)
        dateFormatter.dateFormat = "yyyy-MM"
        self.getDiaryDate = dateFormatter.string(from: Date.init())
        self.bringdays.removeAll()
//        DBDiary.newDiary.getDiary(userID: currentUser, shortDate: self.getDiaryDate, completion: { result in //result에 Day(emoji: "😢", date: "2021-01-03", content: "getDiary")형식으로 저장되어있음
//            self.bringdays.append(result)
//            print("app delegate \(result)")
//            self.tableView.reloadData()
//        })
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        tableView.rowHeight = UITableView.automaticDimension
        
        self.bringdays.removeAll()
        DBDiary.newDiary.getDiary(userID: currentUser, shortDate: self.getDiaryDate, completion: { result in //result에 Day(emoji: "😢", date: "2021-01-03", content: "getDiary")형식으로 저장되어있음
            self.bringdays.append(result)
            print("app delegate \(result)")
            self.tableView.reloadData()
        })
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    @IBAction func unwindToDiaryList(_ unwindSegue: UIStoryboardSegue) {
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
        switch bringdays[indexPath.row].emoji {
        case 0:
            cell.emojiImage.image = img0
        case 1:
            cell.emojiImage.image = img1
        case 2:
            cell.emojiImage.image = img2
        case 3:
            cell.emojiImage.image = img3
        case 4:
            cell.emojiImage.image = img4
        default:
            print("emojiImage")
        }
       
        cell.dateLabel.text = bringdays[indexPath.row].date
        cell.contentLabel.text = bringdays[indexPath.row].content

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
}

extension DiaryController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        performSegue(withIdentifier: "popupDiary", sender: bringdays[indexPath.row])
    }
    
}

