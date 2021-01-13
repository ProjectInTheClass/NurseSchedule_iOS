//
//  MedicalDetailViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/14.
//

import UIKit

class MedicalDetailViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var englishTerm: UILabel!
    @IBOutlet weak var koreanTerm: UILabel!
    @IBOutlet weak var definition: UILabel!
    
    var term : Term? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        englishTerm.text = term?.englishTerm
        koreanTerm.text = term?.koreanTerm
        definition.text = term?.definition
        navigationBar?.title = term?.englishTerm
        
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
