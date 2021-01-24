//
//  boardListCell.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/24.
//

import UIKit

class boardListCell: UITableViewCell {

    @IBOutlet weak var boardList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
