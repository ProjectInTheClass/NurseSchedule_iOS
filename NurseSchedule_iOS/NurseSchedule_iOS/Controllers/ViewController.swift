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

    
 
    
//    @IBAction func Logout(_ sender: Any) {
//        //구글 연동 로그아웃
//        let firebaseAuth = Auth.auth()
//      do {
//        try firebaseAuth.signOut()
//      } catch let signOutError as NSError {
//        print ("Error signing out: %@", signOutError)
//      }
//    }
//
    //    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
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


}
