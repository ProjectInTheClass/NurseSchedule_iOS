//
//  TabBarController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/07.
//

import UIKit
import Firebase
import GoogleSignIn

class TabBarController: UITabBarController {
    
    //let noUser = "no"
    var currentUser : String? 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.selectedIndex = 2

        
        /*
        //로그인 여부 확인 
        Auth.auth().addIDTokenDidChangeListener { (auth, user) in
            let currentUser = Login.init().googleLogin()
            
            if currentUser != nil {
                self.selectedIndex = 2
            } else {
                
            }
            
            
            
            
           */
            
            
            
//            //print("CurrentUser uid is "+currentUser)
//            if currentUser == self.noUser {
//                //self.performSegue(withIdentifier: "GLogin", sender: nil)
//                //구글 로그인
//                GIDSignIn.sharedInstance()?.presentingViewController = self
//                GIDSignIn.sharedInstance().signIn()
//
//            } else {
//                //signInButton.isHidden = true
//
//                self.selectedIndex = 2
//            }
            
        }
        
        
        //let test = DBUser.users.setUser(userName : "lee" ,userEmail : "lee@dgu.ac.kr")
        //DBUser.users.getUser(test)
        
        // Do any additional setup after loading the view.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
