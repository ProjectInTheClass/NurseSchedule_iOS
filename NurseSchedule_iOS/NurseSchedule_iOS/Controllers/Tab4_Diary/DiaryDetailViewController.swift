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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class ModalViewController: UIViewController {
        override func viewDidLoad() {
        }
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
