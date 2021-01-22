//
//  ArticleContentLabel.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/23.
//

import UIKit

@IBDesignable
class ArticleContentLabel: UILabel {

    @IBInspectable var padding : UIEdgeInsets = UIEdgeInsets(top: 0, left : 0, bottom : 2, right: 0)
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
    }
    

}
