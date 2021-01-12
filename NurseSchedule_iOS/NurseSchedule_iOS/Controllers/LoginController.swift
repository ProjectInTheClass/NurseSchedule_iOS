//
//  LoginController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/10.
//

import Foundation
import Firebase
import GoogleSignIn


struct Login {
   
    let noUser = "no"
    
    func googleLogin() -> String {
        //Google user manage
        //https://firebase.google.com/docs/auth/ios/manage-users
        //구글 로그인
        
        let user = Auth.auth().currentUser
        let uid : String
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          uid = user.uid
//          let email = user.email
//          let photoURL = user.photoURL
//          var multiFactorString = "MultiFactor: "
//          for info in user.multiFactor.enrolledFactors {
//            multiFactorString += info.displayName ?? "[DispayName]"
//            multiFactorString += " "
//          }
          // ...
        } else {
            uid = noUser
        }
        
        return uid
       
    }
}
