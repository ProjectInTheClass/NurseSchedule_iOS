//
//  ScheduleController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase
import FSCalendar

class ScheduleController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarBottom: NSLayoutConstraint!
    
    
    //FSCalendar
    //https://ahyeonlog.tistory.com/7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //캘린더 위로 올라가게
        //calendarBottom.constant = 300
        
        //        let test = DBUser.users.setUser(userName : "lee" ,userEmail : "lee@dgu.ac.kr")
        //
        //        DBUser.users.getUser(test)
        updateUI()
        
        //        Auth.auth().addIDTokenDidChangeListener { (auth, user) in
        //            self.updateUI()
        //        }
        // Do any additional setup after loading the view.
    }
    
    //창 가려졌다가 다시 보이거나 암튼 내 화면 다시 보이게 될 때
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        //calendar
        calendar.allowsMultipleSelection = true
        calendar.delegate = self
        calendar.dataSource = self
        
        
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
    
    
    
    @IBAction func capture(_ sender: Any) {
        captureScreenshot()
        
    }
    
    //스크린샷
    func captureScreenshot(){
        let layer = self.calendar.layer
        let scale = UIScreen.main.scale
        // Creates UIImage of same size as view
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // THIS IS TO SAVE SCREENSHOT TO PHOTOS
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
        // screenshot effect
        if let wnd = self.view{
            
            var calenderView = UIView(frame: wnd.bounds)
            calenderView.backgroundColor = UIColor.white
            calenderView.alpha = 1
            
            wnd.addSubview(calenderView)
            UIView.animate(withDuration: 1, animations: {
                calenderView.alpha = 0.0
            }, completion: {(finished:Bool) in
                calenderView.removeFromSuperview()
            })
        }
    }
    
}
