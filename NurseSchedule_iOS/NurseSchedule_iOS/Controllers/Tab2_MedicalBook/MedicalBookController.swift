//
//  MedicalBookController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase


class MedicalBookController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    let firstLetters:[String] = [
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
    ]
    
    //searchbar에 의해 검색결과가 저장될 array
    var filteredTermsBySearchbar : [Term]!
    
    // tableview에 뿌려질 데이터를 지니는 array
    var outputDataForTableView = [Term]() {
        didSet {
            sortedDataForTableView = outputDataForTableView.sorted{ $0.englishTerm < $1.englishTerm }
            self.tableView.reloadData()
        }
    }
    
    // 정렬된 데이터 배열
    var sortedDataForTableView = [Term]()
    
    
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
        outputDataForTableView = termsList
        //filteredTermsBySearchbar = termsList
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "termDetail" {
            let viewcontollerToMedicalDetail = segue.destination as! MedicalDetailViewController
            viewcontollerToMedicalDetail.term = sender as? Term
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
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.firstLetters
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.firstLetters[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.firstLetters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedDataForTableView
//            .filter({ data in
//            return data.englishTerm.starts(with: self.firstLetters[section])
//        })
            .count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalCell", for: indexPath) as! MedicalCell
//        let source = sortedDataForTableView.filter({ data in
//            return data.englishTerm.starts(with: self.firstLetters[indexPath.section])
//        })
        let term = sortedDataForTableView[indexPath.row]
        
        // print("tableView>>>>> \(term)")
        cell.update(with: term)
        
        cell.showsReorderControl = true
        return cell
    }
}




extension MedicalBookController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        //print(sortedDataForTableView[indexPath.row])
        let source = sortedDataForTableView.filter({ data in
            return data.englishTerm.starts(with: self.firstLetters[indexPath.section])
        })
        performSegue(withIdentifier: "termDetail", sender: source[indexPath.row])
    }
}


extension MedicalBookController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            filteredTermsBySearchbar = termsList
        } else {
            filteredTermsBySearchbar = []
            // termsList = allData
            filteredTermsBySearchbar = termsList.filter({
                $0.englishTerm.lowercased().contains(searchText.lowercased())
            })
            //termsList = filteredTerms
        }
        outputDataForTableView = filteredTermsBySearchbar
        //termsList = filteredTerms
        self.tableView.reloadData()
    }
    
}
