//
//  ContentCell.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/21.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var ContentNum: UILabel!
    @IBOutlet weak var ContentDate: UILabel!
    @IBOutlet weak var ContentTitle: UILabel!
    @IBOutlet weak var ContentContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
