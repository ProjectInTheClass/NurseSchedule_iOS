//
//  DiaryCell.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/17.
//

import UIKit

class DiaryCell: UITableViewCell {


    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
