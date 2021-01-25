//
//  SerialNumController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/25.
//

import UIKit

class SerialNumController: UIViewController {

    
    @IBOutlet weak var serialNum: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        serialNum.text = currentUser

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = currentUser
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
