//
//  SettingTableViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/13.
//

import UIKit
import Firebase
import GoogleSignIn

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var sectionOneCellOne: UITableViewCell!
    @IBOutlet weak var sectionTwoCellOne: UITableViewCell!
    @IBOutlet weak var sectionTwoCellTwo: UITableViewCell!
    @IBOutlet weak var sectionThreeCellOne: UITableViewCell!
    @IBOutlet weak var sectionThreeCellTwo: UITableViewCell!
    
    let numberOfsections : [Int] = [1,2,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfsections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfsections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    sectionOneCellOne.textLabel?.text = "나의 일련 번호"
                    sectionOneCellOne.detailTextLabel?.text = currentUser
                    return sectionOneCellOne
                default:
                    break
                }
        case 1:
            switch indexPath.row {
            case 0:
                       sectionTwoCellOne.textLabel?.text = "내가 쓴 글"
                return sectionTwoCellOne
            case 1:
                       sectionTwoCellTwo.textLabel?.text = "내가 쓴 댓글"
                return sectionTwoCellTwo
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                sectionThreeCellOne.textLabel?.text = "앱버전"
                sectionThreeCellOne.detailTextLabel?.text = "1.1"
                return sectionThreeCellOne
            case 1:
                sectionThreeCellTwo.detailTextLabel?.text = "로그아웃"
                return sectionThreeCellTwo
            default:
                break
            }
        default :
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    performSegue(withIdentifier: "serialNumCheck", sender: nil)
                default:
                    break
                }
        case 1:
            switch indexPath.row {
            case 0:
               performSegue(withIdentifier: "showMyContent", sender: nil)
            case 1:
                performSegue(withIdentifier: "showMyComment", sender: nil)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
               print("app version")
            case 1:
               Logout()
            default:
                break
            }
        default :
            break
        }
    }
    

    func Logout() {
       
        let alert = UIAlertController(title: "로그아웃하시겠습니까?", message: "😭", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let okAction = UIAlertAction(title: "확인", style: .destructive) {_ in
            
            let firebaseAuth = Auth.auth()
          do {
            try firebaseAuth.signOut()
          } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
          }
            
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
        
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
