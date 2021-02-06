//
//  SettingMainTableViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/02/06.
//

import UIKit
import Firebase
import MessageUI

class SettingMainTableViewController: UITableViewController {

    @IBOutlet weak var sectionOneCellOne: UITableViewCell!
    @IBOutlet weak var sectionOneCellTwo: UITableViewCell!
    @IBOutlet weak var sectionTwoCellOne: UITableViewCell!
    @IBOutlet weak var sectionTwoCellTwo: UITableViewCell!
    @IBOutlet weak var sectionTwoCellThree: UITableViewCell!
    
    let numberOfsections : [Int] = [2]
    
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

 
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: //section1
            switch indexPath.row{
            case 0 :
                break
            case 1 :
                let mailComposeViewController = configuredMailComposeViewController()
                       if MFMailComposeViewController.canSendMail() {
                        self.present(mailComposeViewController, animated: true, completion: nil)
                        
                       } else {
                           self.showSendMailErrorAlert()
                       }

                
                break
            default:
                break
            }
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    
    

}

extension SettingMainTableViewController : MFMailComposeViewControllerDelegate {
    func configuredMailComposeViewController() -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["leeez0128@gmail.com"])
            mailComposerVC.setSubject("널'스케줄")
            mailComposerVC.setMessageBody("여러분의 소중한 의견 감사드립니다. \n - 널'스케줄 개발자 -", isHTML: false)
            return mailComposerVC
        }
        
        func showSendMailErrorAlert() {
            let alert = UIAlertController(title: "메일 전송 실패", message: "이메일 설정 확인 후 다시 시도해주세요", preferredStyle: .alert)
            
            // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
            let okAction = UIAlertAction(title: "OK", style: .default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            
        }
    }
    
}
