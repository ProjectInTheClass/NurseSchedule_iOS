//
//  ViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2020/12/31.
//

import UIKit
import Firebase


class ViewController: UIViewController {
//    var ref : DatabaseReference!
    override func viewDidLoad() {

        
        //회원가입 시
        //DBStruct.users.setUser()
        
        //currentUser이런거에 로그인된 회원 일련번호 저장해뒀겠지 그럼
        //이건 일단 회원가입으로 테스트
        let test = DBUser.users.setUser(userName : "lee",userEmail : "lee@dgu.ac.kr")

        DBUser.users.getUser(test)


        
        DBBoard.board.addBoard(B_maker : "고객센터", B_description : "문의바랍니다.")
  
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

