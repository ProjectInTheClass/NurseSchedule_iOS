//
//  SettingMainTableController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/02/04.
//

import UIKit
import Firebase

class SettingMainTableController: UITableViewController {

    @IBOutlet weak var sectionOneCellOne: UITableViewCell!
    @IBOutlet weak var sectionOneCellTwo: UITableViewCell!
    @IBOutlet weak var sectionTwoCellOne: UITableViewCell!
    @IBOutlet weak var sectionTwoCellTwo: UITableViewCell!
    @IBOutlet weak var sectionTwoCellThree: UITableViewCell!
    
    let numberOfsections : [Int] = [2,3]
    
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
                    sectionOneCellOne.textLabel?.text = "1-1"
                    sectionOneCellOne.detailTextLabel?.text = "선택한 글꼴"
                    return sectionOneCellOne
                case 1:
                    sectionOneCellTwo.textLabel?.text = " 1-2"
                    sectionOneCellTwo.detailTextLabel?.text = "선택한 테마"
                    return sectionOneCellTwo
                default:
                    break
                }
        case 1:
            switch indexPath.row {
            case 0:
                sectionTwoCellOne.textLabel?.text = "2-1"
                sectionTwoCellOne.detailTextLabel?.text = "앱 버전 수"
                return sectionTwoCellOne
            case 1:
                sectionTwoCellTwo.textLabel?.text = " 2-2 개인정보처리방침"
                return sectionTwoCellTwo
            case 2 :
                sectionTwoCellThree.textLabel?.text = " 2-3 의견보내기"
                return sectionTwoCellThree
            default:
                break
            }
        default:
            break
        }
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: //section1
            switch indexPath.row{
            case 0 : //글꼴 선택 table
                performSegue(withIdentifier: "identifier이름", sender: nil)
            case 1 : //테마 선택 table
                performSegue(withIdentifier: "identifier이름", sender: nil)
            default:
                break
            }
        case 1: //section2
            switch indexPath.row {
            case 1: // 개인정보처리방침
                performSegue(withIdentifier: "identifier이름", sender: nil)
            case 2: // 의견보내기
                performSegue(withIdentifier: "identifier이름", sender: nil)
            default:
                break
            }
        default:
            break
        }
    }
}
