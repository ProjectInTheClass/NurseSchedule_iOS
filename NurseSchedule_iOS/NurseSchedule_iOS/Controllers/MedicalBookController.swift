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

class MedicalBookController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    //searchbar에 의해 검색결과가 저장될 array
    var filteredTerms : [Term]!
    
    // tableview에 뿌려질 데이터를 지니는 array
    var outputData = [Term]()
    
    let ref = Database.database().reference().child("Medical/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // retrieveTerms()
        tableView.dataSource = self
        tableView.delegate = self
        searchbar.delegate = self
        searchbar.placeholder = "용어를 검색하세요."
        print("viewdidload>>>>>\(termsList)")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredTerms = termsList
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
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
    
    
}

extension MedicalBookController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outputData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalCell", for: indexPath) as! MedicalCell
        let term = outputData[indexPath.row]
        
       // print("tableView>>>>> \(term)")
        cell.update(with: term)
        
        cell.showsReorderControl = true
        return cell
    }
}




extension MedicalBookController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(outputData[indexPath.row])
        
        performSegue(withIdentifier: "termDetail", sender: outputData[indexPath.row])
    }
}


extension MedicalBookController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            filteredTerms = termsList
        } else {
            filteredTerms = []
           // termsList = allData
            filteredTerms = termsList.filter({
                $0.englishTerm.lowercased().contains(searchText.lowercased())
            })
            //termsList = filteredTerms
        }
        outputData = filteredTerms
        //termsList = filteredTerms
        self.tableView.reloadData()
    }

}
