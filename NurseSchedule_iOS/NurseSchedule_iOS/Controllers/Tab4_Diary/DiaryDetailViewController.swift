//
//  DiaryDetailViewController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/18.
//

import UIKit



class DiaryDetailViewController: UIViewController {
    

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var content: UITextView!
    
    var detailInfoFromDay : Day? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        date.text = detailInfoFromDay?.date
        emoji.text = detailInfoFromDay?.emoji
        content.text = detailInfoFromDay?.content
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

}
