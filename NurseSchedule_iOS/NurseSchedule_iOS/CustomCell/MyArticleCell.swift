//
//  MyArticleCell.swift
//  NurseSchedule_iOS
//
//  Created by 강성희 on 2021/01/27.
//

import UIKit

class MyArticleCell: UITableViewCell {

    @IBOutlet weak var boardType: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
