//
//  DiaryController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import RealmSwift

let realm = try! Realm()

class DiaryController: UIViewController {
    
    let img0 = UIImage(named: "0-love.png")
    let img1 = UIImage(named: "0-happy.png")
    let img2 = UIImage(named: "0-surprised.png")
    let img3 = UIImage(named: "0-crying.png")
    let img4 = UIImage(named: "0-devil.png")
    @IBOutlet weak var tableView: UITableView!
    
    let dateFormatter : DateFormatter = DateFormatter()
    var month : String = ""
    
    private var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let savedDiary = realm.objects(Diary.self)
       
        initRefresh()

        print("selectedDiary")
//        print(selectedDiary)
        
 
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        
    }
    func initRefresh(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "" )
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = refresh
        }else {
            tableView.addSubview(refresh)
        }
    }
    
    @objc func updateUI(refresh : UIRefreshControl){
        refresh.endRefreshing()
        tableView.reloadData()
    }
    
    

    @IBAction func addDiaryButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addDiary", sender: nil)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.rowHeight = UITableView.automaticDimension
    }

    @IBAction func unwindToDiaryList(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
        tableView.reloadData()
    }
  
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupDiary" {
            let detailDiaryFromTableController = segue.destination as! DetailDiaryFromTableController
            detailDiaryFromTableController.selectedDate = (sender as? String)!
        }
        tableView.reloadData()
     }
}

extension DiaryController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dateFormatter.dateFormat = "yyyy-MM"
        month = dateFormatter.string(from: Date.init())
         //let selectedDiary = savedDiary.contains("date == '\(month)'")
        let selectedDiary = realm.objects(Diary.self).filter("date CONTAINS '\(month)'")
        return selectedDiary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell
        

        dateFormatter.dateFormat = "yyyy-MM"
        month = dateFormatter.string(from: Date.init())
        let monthlyDiary = realm.objects(Diary.self).filter("date CONTAINS '\(month)'")
    
        
        
        switch monthlyDiary[indexPath.row].emoji {
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
       
        cell.dateLabel.text = monthlyDiary[indexPath.row].date
        cell.contentLabel.text = monthlyDiary[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DiaryController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        dateFormatter.dateFormat = "yyyy-MM"
        month = dateFormatter.string(from: Date.init())
        let monthlyDiary = realm.objects(Diary.self).filter("date CONTAINS '\(month)'")
        performSegue(withIdentifier: "popupDiary", sender: monthlyDiary[indexPath.row].date)
        tableView.reloadData()
       
    }
    
}


