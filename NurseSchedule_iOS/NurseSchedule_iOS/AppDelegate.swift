//
//  AppDelegate.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2020/12/31.
//

import UIKit
import Firebase
import GoogleSignIn

var termsList = [Term]()
@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        
        let ref = Database.database().reference().child("Medical/")
        
        for i in 1...11052 {
        _ = ref.child("\(i)").observe(.value, with: { snapshot in
            
            var newTerm = Term(definition: "There's no Description", englishTerm: "retriveE", koreanTerm: "retriveK")
            
            //print(snapshot)
            if let value = snapshot.value as? NSDictionary {
                
                newTerm.definition = value["N_definition"] as? String ?? " "//정의 받아오는 부분, 정의에 대한 변수
                //print(value?["N_definition"])
                
                newTerm.englishTerm = value["N_englishName"] as? String ?? " " //영어 이름 받아오는 부분, 영어 이름에 대한 변수
                newTerm.koreanTerm = value["N_koreanName"] as? String ?? " " //한글 이름 받아오는 부분, 한글 이름에 대한 변수
                termsList.append(newTerm)
            }
            
            //self.tableView.reloadData()
            
        })
        }
        print(">>>>>appdelegate \(termsList)")
        
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

