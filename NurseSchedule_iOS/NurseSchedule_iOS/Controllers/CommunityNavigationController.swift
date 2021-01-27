//
//  CommunityNavigationController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/28.
//

import UIKit

class CommunityNavigationController: UINavigationController {

    @IBOutlet weak var navigationbar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "Stupendous Jack", size: 36)
        //navigationbar.topItem?.title = font
        //UINavigationBar.appearance().titleTextAttributes = attributes
        // navigationbar.topItem?.title = "wow"
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
