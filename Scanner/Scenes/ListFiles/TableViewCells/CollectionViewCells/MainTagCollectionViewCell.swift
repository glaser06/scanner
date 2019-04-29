//
//  MainTagCollectionViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class MainTagCollectionViewCell: DefaultDisplayableCell {
    
    override class var identifier: String {
        return "TagCell"
    }
    override class var nibName: String {
        return "MainTagCollectionViewCell"
    }
    
//    static let identifier: String = "TagCell"
//    static let nibName: String = "MainTagCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func setCell(model: ItemModel) {
        if let tag = model as? ListFiles.TagModel {
            self.setCell(tagModel: tag)
        }
    }
    
    func setCell(tagModel: ListFiles.TagModel) {
        self.backView.backgroundColor = tagModel.color
        self.nameLabel.text = tagModel.name
        
//        self.nameLabel.preferredMaxLayoutWidth = 20
//        self.countLabel.text = count
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
