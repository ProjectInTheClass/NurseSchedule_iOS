//
//  NoticeNCenterCell.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/25.
//

import UIKit

class NoticeNCenterCell: UITableViewCell {

    @IBOutlet weak var articleNum: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
