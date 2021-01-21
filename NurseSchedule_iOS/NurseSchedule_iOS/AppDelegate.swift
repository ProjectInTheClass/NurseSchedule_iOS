//
//  AppDelegate.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2020/12/31.
//

import UIKit
import Firebase
import GoogleSignIn

var termsList : [Term] = []

var bringdays : [Day] = []

var getDiaryDate : String = ""
let currentUser = Login.init().googleLogin()




@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // medicalBook 데이터 가져옴
        DBMedical.medicalBookData.getMedicalBookData { (term) in
            termsList.append(term)
        }
        print(">>>>>appdelegate \(termsList)")
        
        
        
        
        
        // 다이어리 목록을 디비에서 불러옴
        let dateFormatter : DateFormatter = DateFormatter() //DB에 들어갈 날짜용 0(월단위)
        dateFormatter.dateFormat = "yyyy-MM"
        getDiaryDate = dateFormatter.string(from: Date.init())
        DBDiary.newDiary.getDiary(userID: currentUser, shortDate: getDiaryDate, completion: { result in //result에 Day(emoji: "😢", date: "2021-01-03", content: "getDiary")형식으로 저장되어있음
            bringdays.append(result)
            print("app delegate \(result)")
            //print(self.bringdays)
        })
        
        return true
    }

   

    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

    //After signIn
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       // print("User email : \(user.profile.email ?? "no email")")
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error{
            //...
            return
            }
        }
//
      // ...
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
  

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

