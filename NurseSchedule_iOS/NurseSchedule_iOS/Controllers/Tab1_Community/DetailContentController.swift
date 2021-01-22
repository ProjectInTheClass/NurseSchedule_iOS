//
//  DetailContentController.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/22.
//

import UIKit

class DetailContentController: UIViewController {

    @IBOutlet weak var articleUser: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    
    var selectedArticle : Article? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleUser.text = "익명"
        articleDate.text = selectedArticle?.date
        articleTitle.text = selectedArticle?.title
        articleContent.text = selectedArticle?.content
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionButton(_ sender: Any) {
        showActionSheet()
    }
    
    
    func showActionSheet(){
        let actionSheet = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertController.Style.actionSheet)
        
        let editButton = UIAlertAction(title: "수정하기", style: .default)
        let deleteButton = UIAlertAction(title: "삭제하기", style: .default)
        
        actionSheet.addAction(editButton)
        actionSheet.addAction(deleteButton)
        
        present(actionSheet, animated: true, completion: nil)
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
