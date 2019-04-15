//
//  FolderCollectionViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell, DisplayableCell {
    
    static let identifier: String = "FolderCell"
    static let nibName: String = "FolderCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLabel: UILabel!
    func setCell(name: String) {
        
        self.nameLabel.text = name
        
        self.isHeightCalculated = false
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    
    var isHeightCalculated: Bool = false
    //    https://stackoverflow.com/questions/25895311/uicollectionview-self-sizing-cells-with-auto-layout
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }

}
