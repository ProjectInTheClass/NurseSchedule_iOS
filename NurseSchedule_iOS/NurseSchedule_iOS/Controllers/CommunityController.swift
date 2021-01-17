//
//  CommunityController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import SafariServices

class CommunityController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //using SafariServices
    @IBAction func firstLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://www.koreanurse.or.kr/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func secondLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://www.nursejob.co.kr/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    @IBAction func thirdLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://recruit.nurscape.net/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    @IBAction func fourthLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://www.nursestory.co.kr/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
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

    // 링크넘어가기
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "koreanurseWeb" {
//            if let vc = segue.destination as? ViewLinc {
//                vc.urlString = "https://www.koreanurse.or.kr/"
//            }
//        } else if segue.identifier == "nursejobWeb" {
//            if let vc = segue.destination as? ViewLinc {
//                vc.urlString = "https://www.nursejob.co.kr/"
//            }
//        } else if segue.identifier == "nurscapeWeb" {
//            if let vc = segue.destination as? ViewLinc {
//                vc.urlString = "https://recruit.nurscape.net/"
//            }
//        } else if segue.identifier == "NursestoryWeb" {
//            if let vc = segue.destination as? ViewLinc {
//                vc.urlString = "https://www.nursestory.co.kr/"
//            }
//        }
//    }
}
