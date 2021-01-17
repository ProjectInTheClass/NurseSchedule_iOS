//
//  MedicalCell.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/13.
//

import UIKit

class MedicalCell: UITableViewCell {

    @IBOutlet weak var englishTerm: UILabel!
    @IBOutlet weak var koreanTerm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func update(with term : Term) {
        englishTerm.text = term.englishTerm
        koreanTerm.text = term.koreanTerm
    }

}
