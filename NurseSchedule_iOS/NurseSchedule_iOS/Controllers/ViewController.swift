//
//  ViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2020/12/31.
//

import UIKit
import Firebase
import GoogleSignIn


class ViewController: UIViewController {

    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    

    var currentUser : String? = Auth.auth().currentUser?.uid {
        didSet {
            performSegue(withIdentifier: "unwindToSchedule", sender: currentUser)
            print(currentUser)
            print("‼️LOGIN success")
        }
    }
    
  

    
    //    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        print("ViewDidLOAD‼️\(currentUser)")
        
     //  Auth.auth().addIDTokenDidChangeListener { (auth, user) in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //currentUser = Auth.auth().currentUser?.uid
        
//            if let currentUser = auth.currentUser?.uid {
//                self.performSegue(withIdentifier: "unwindToSchedule", sender: currentUser)
//            } else {
//                GIDSignIn.sharedInstance().signIn()
//            }
    //    }
        

        
        //회원가입 시
        //DBStruct.users.setUser()
        
        //currentUser이런거에 로그인된 회원 일련번호 저장해뒀겠지 그럼
        //이건 일단 회원가입으로 테스트
//        let test = DBUser.users.setUser(userName : "lee" ,userEmail : "lee@dgu.ac.kr")
//
//        DBUser.users.getUser(test)


    
        
        //새로운 게시판 만드는 방법
       // DBBoard.board.addBoard(B_maker : "고객센터", B_description : "문의바랍니다.")

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear‼️\(currentUser)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("ViewDidAppear‼️\(currentUser)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
        
