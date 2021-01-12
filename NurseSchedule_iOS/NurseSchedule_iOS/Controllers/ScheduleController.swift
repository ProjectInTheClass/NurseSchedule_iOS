//
//  ScheduleController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase
import GoogleSignIn
import FSCalendar

class ScheduleController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet var signInButton: GIDSignInButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var logoutButton: UIButton!
    
    //FSCalendar
    //https://ahyeonlog.tistory.com/7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let test = DBUser.users.setUser(userName : "lee" ,userEmail : "lee@dgu.ac.kr")
//
//        DBUser.users.getUser(test)
        updateUI()
        
//        Auth.auth().addIDTokenDidChangeListener { (auth, user) in
//            self.updateUI()
//        }
        // Do any additional setup after loading the view.
    }
    
    //창 가려졌다가 다시 보이거나 암튼 내 화면 다시 보이게 될 때
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        //calendar
        calendar.allowsMultipleSelection = true
        calendar.delegate = self
        calendar.dataSource = self

       
    }
    
    @IBAction func Logout(_ sender: Any) {
        //구글 연동 로그아웃
        let firebaseAuth = Auth.auth()
      do {
        try firebaseAuth.signOut()
        //logoutButton.isHidden = true
      } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
      }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
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
