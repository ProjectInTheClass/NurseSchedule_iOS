//
//  DictionaryLabel.swift
//  NurseSchedule_iOS
//
//  Created by 박흥기 on 2021/01/24.
//

import UIKit

class DictionaryLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: textRect)
      }

}
