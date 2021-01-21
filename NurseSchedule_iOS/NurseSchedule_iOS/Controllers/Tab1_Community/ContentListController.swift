//
//  ContentListController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/21.
//

import UIKit

class ContentListController: UIViewController , UITableViewDataSource{
   

    struct Data {
        var num : Int
        var date : String
        var title : String
        var content : String
    }


    var data : [Data] = [
        Data(num: 1, date: "날짜1", title: "제목1", content: "내용1"),
        Data(num: 2, date: "날짜2", title: "제목2", content: "내용2")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        cell.ContentNum.text = "\(data[indexPath.row].num)"
        cell.ContentDate.text = data[indexPath.row].date
        cell.ContentTitle.text = data[indexPath.row].title
        cell.ContentContent.text = data[indexPath.row].content
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}
