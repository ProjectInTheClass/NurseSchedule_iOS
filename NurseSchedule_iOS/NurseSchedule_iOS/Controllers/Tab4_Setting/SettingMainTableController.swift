//
//  SettingMainTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/02/04.
//

import UIKit
import Firebase
import MessageUI

class SettingMainTableController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sectionOneCellOne: UITableViewCell!
    @IBOutlet weak var sectionOneCellTwo: UITableViewCell!
    @IBOutlet weak var sectionTwoCellOne: UITableViewCell!
    @IBOutlet weak var sectionTwoCellTwo: UITableViewCell!
    @IBOutlet weak var sectionTwoCellThree: UITableViewCell!
    
    let numberOfsections : [Int] = [2]
    var composeVC = MFMailComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
         return numberOfsections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfsections[section]
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    sectionOneCellOne.textLabel?.text = "앱 버전"
                    sectionOneCellOne.detailTextLabel?.text = "v1.0"
                    return sectionOneCellOne
                case 1:
                    sectionOneCellTwo.textLabel?.text = "의견보내기"
                    return sectionOneCellTwo
                default:
                    break
                }
//        case 1:
//            switch indexPath.row {
//            case 0:
//                sectionTwoCellOne.textLabel?.text = "2-1"
//                sectionTwoCellOne.detailTextLabel?.text = "앱 버전 수"
//                return sectionTwoCellOne
//            case 1:
//                sectionTwoCellTwo.textLabel?.text = " 2-2 개인정보처리방침"
//                return sectionTwoCellTwo
//            case 2 :
//                sectionTwoCellThree.textLabel?.text = " 2-3 의견보내기"
//                return sectionTwoCellThree
//            default:
//                break
//            }
        default:
            break
        }
        return cell
    }

    func sendEmail() {
           composeVC.mailComposeDelegate = self
           // Configure the fields of the interface.
           composeVC.setToRecipients(["tjdgml_27@daum.net"])
           composeVC.setSubject("제목")
           composeVC.setMessageBody("의견을 작성해주세요", isHTML: false)
           // Present the view controller modally.
           self.present(composeVC, animated: true, completion: nil)
       }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: //section1
            switch indexPath.row{
            case 0 :
                break
            case 1 :
                composeVC = MFMailComposeViewController()
                            composeVC.delegate = self
                            composeVC.mailComposeDelegate = self
                            if !MFMailComposeViewController.canSendMail() {
                                print("Mail services are not available")
                                return
                            }
                            sendEmail()
                break
            default:
                break
            }
//        case 1: //section2
//            switch indexPath.row {
//            case 1: // 개인정보처리방침
//                performSegue(withIdentifier: "identifier이름", sender: nil)
//            case 2: // 의견보내기
//                performSegue(withIdentifier: "identifier이름", sender: nil)
//            default:
//                break
//            }
//        default:
//            break
//        }
        default:
            break
        }
    }

  
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
       }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    
    

}


