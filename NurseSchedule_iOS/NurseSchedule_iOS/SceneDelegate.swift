//
//  SceneDelegate.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2020/12/31.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        Auth.auth().addStateDidChangeListener { (_, user) in
            if let user = user {
                // 로그인 된 상태
                print("=-=-=-=--=-=-=-=--=-")
                if let tabBar = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTab") as? TabBarController {
                    window.rootViewController = tabBar
                    self.window = window
                    window.makeKeyAndVisible()
                }
            } else {
                // 로그인 안된 상태
                if let loginVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginVC") as? ViewController {
                    window.rootViewController = loginVC
                    self.window = window
                    window.makeKeyAndVisible()
                }
            }
        }
//        guard let tabBarController = self.window?.rootViewController?.presentedViewController as? UITabBarController else { return }
//        guard let tabBarViewControllers = tabBarController.viewControllers else { return }
//        guard let mainViewController = tabBarViewControllers[0] as? MainViewController else { return }
//        tabBarController.selectedIndex = 0
//        mainViewController(withIdentifier: "ScheduleController", sender: nil)
//        
//    
    
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

