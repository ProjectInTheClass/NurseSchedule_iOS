//
//  MedicalBookController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase

struct Term {
    var definition : String
    var englishTerm : String
    var koreanTerm : String
}

class MedicalBookController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    //var termsList = [Term]()
    
    let ref = Database.database().reference().child("Medical/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // retrieveTerms()
        tableView.dataSource = self
        tableView.delegate = self
        print("viewdidload>>>>>\(termsList)")
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalCell", for: indexPath) as! MedicalCell
        
        let term = termsList[indexPath.row]
        
       // print("tableView>>>>> \(term)")
        
        cell.englishTerm.text = term.englishTerm
        cell.koreanTerm.text = term.koreanTerm
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "termDetail" {
            let vc = segue.destination as! MedicalDetailViewController
            vc.term = sender as? Term
        }
    }
    
    
//    func retrieveTerms(){
//
//        print(">>>>>termslist \(self.termsList)")
//
//
//        //DispatchQueue.main.async {
//            _ = self.ref.child("1").observe(.value, with: { snapshot in
//
//                var newTerm = Term(definition: "retrive", englishTerm: "retriveE", koreanTerm: "retriveK")
//
//                //print(snapshot)
//                if let value = snapshot.value as? NSDictionary {
//
//                    newTerm.definition = value["definition"] as? String ?? " "//정의 받아오는 부분, 정의에 대한 변수
//                    //print(value?["N_definition"])
//
//                    newTerm.englishTerm = value["englishTerm"] as? String ?? " " //영어 이름 받아오는 부분, 영어 이름에 대한 변수
//                    newTerm.koreanTerm = value["koreanTerm"] as? String ?? " " //한글 이름 받아오는 부분, 한글 이름에 대한 변수
//                    self.termsList.append(newTerm)
//                }
//                print(">>>>>termslist2 \(self.termsList)")
//                self.tableView.reloadData()
//
//
//            })
//
//       // }
//        print(">>>>>termslist3 \(self.termsList)")
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension MedicalBookController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(termsList[indexPath.row])
        
        performSegue(withIdentifier: "termDetail", sender: termsList[indexPath.row])
    }
}
