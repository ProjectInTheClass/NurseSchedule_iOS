//
//  ScheduleController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase
import GoogleSignIn

class ScheduleController: UIViewController {

    @IBOutlet var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = Login.init().googleLogin()
        print("CurrentUser uid is "+currentUser)
        if currentUser == "no" {
            signInButton.isHidden = false
            //구글 로그인
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance().signIn()
            
        } else {
            signInButton.isHidden = true
        }
       
        // Do any additional setup after loading the view.
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
