//
//  ViewLinc.swift
//  NurseSchedule_iOS
//
//  Created by 박흥기 on 2021/01/11.
//
import WebKit
import UIKit

class ViewLinc: UIViewController {

    @IBOutlet weak var WebViewLink: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let urlString = "https://www.google.com/"
        if let url = URL(string: urlString){
            let urlReq = URLRequest(url: url)
            WebViewLink.load(urlReq)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
