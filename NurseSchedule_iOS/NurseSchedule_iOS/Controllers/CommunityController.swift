//
//  CommunityController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit

class CommunityController: UIViewController {

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

    // 링크넘어가기
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "koreanurseWeb" {
            if let vc = segue.destination as? ViewLinc {
                vc.urlString = "https://www.koreanurse.or.kr/"
            }
        } else if segue.identifier == "nursejobWeb" {
            if let vc = segue.destination as? ViewLinc {
                vc.urlString = "https://www.nursejob.co.kr/"
            }
        } else if segue.identifier == "nurscapeWeb" {
            if let vc = segue.destination as? ViewLinc {
                vc.urlString = "https://recruit.nurscape.net/"
            }
        } else if segue.identifier == "NursestoryWeb" {
            if let vc = segue.destination as? ViewLinc {
                vc.urlString = "https://www.nursestory.co.kr/"
            }
        }
    }
}
