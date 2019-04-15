//
//  NewPageCollectionViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/11/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class NewPageCollectionViewCell: UICollectionViewCell, DisplayableCell {
    
    static var identifier: String = "NewPageCell"
    static var nibName: String = "NewPageCollectionViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setCell() {
//        https://stackoverflow.com/questions/13679923/dashed-line-border-around-uiview
        var yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(yourViewBorder)
    }

}
