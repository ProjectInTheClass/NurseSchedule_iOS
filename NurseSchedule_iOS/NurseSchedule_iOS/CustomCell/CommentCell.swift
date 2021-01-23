//
//  CommentCell.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/23.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentUser: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var commentContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
