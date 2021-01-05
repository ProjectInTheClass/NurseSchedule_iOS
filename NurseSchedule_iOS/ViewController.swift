//
//  ViewController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2020/12/31.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    var ref : DatabaseReference!

    override func viewDidLoad() {
        
        ref = Database.database().reference()
        _ = ref.child("Users").observe(.value, with :{ snapshot in
            print(snapshot)
        })

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

