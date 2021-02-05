//
//  MedicalBookController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import Firebase
import RealmSwift
import CSV



class MedicalBookController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    let firstLetters:[String] = [
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
    ]
    
    
    var medicalTermList : [String] = []
    
    //searchbar에 의해 검색결과가 저장될 array
    var filteredTermsBySearchbar : [Term]!
    
    // tableview에 뿌려질 데이터를 지니는 array
    var outputDataForTableView = [Term]()
    
    
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // retrieveTerms()
        tableView.dataSource = self
        tableView.delegate = self
        searchbar.delegate = self
        searchbar.placeholder = "용어를 검색하세요."
        tableView.reloadData()
        

//        let termDataFromDB = realm.objects(MedicalBook.self)
//        if termDataFromDB.isEmpty{
//            let test = readFileFrom()
//            print(test)
//        }

    }
    
    
//    func readFileFrom() -> [[String]] {
//        if let csvPath = Bundle.main.path (forResource: "보건의료용어표준_v5.0_간호", ofType: "csv"){
//        do {
//        let content = try String (contentsOfFile: csvPath, encoding: String.Encoding.utf8)
//        let data: [[String]] = content.components(separatedBy: "\r\n").map { $0.components(separatedBy: ",") }
//        return data
//      } catch {
//        //
//      }
//        }
//      return [["never be printed"]]
//    }
    
    
   
    
    
    
    
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
        return outputDataForTableView.filter({ data in
            return data.englishTerm.starts(with: self.firstLetters[section])
        }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalCell", for: indexPath) as! MedicalCell
        let filteredData = outputDataForTableView.filter({ data in
            return data.englishTerm.starts(with: self.firstLetters[indexPath.section])
        })
        let term = filteredData[indexPath.row]
        
        // print("tableView>>>>> \(term)")
        cell.update(with: term)
        //tableView.reloadData()
        return cell
    }
}




extension MedicalBookController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        //print(sortedDataForTableView[indexPath.row])
        let source = outputDataForTableView.filter({ data in
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
            //filteredTermsBySearchbar = []
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
