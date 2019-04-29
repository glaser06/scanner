//
//  ShowTagsCollectionViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/18/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class ShowTagsCollectionViewCell: DefaultDisplayableCell {
    
    override class var identifier: String {
        return "TagCell"
    }
    override class var nibName: String {
        return "ShowTagsCollectionViewCell"
    }
    
    
//    static let identifier: String = "TagCell"
//    static let nibName: String = "ShowTagsCollectionViewCell"
    
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
//        self.layoutIfNeeded()
        //        self.nameLabel.preferredMaxLayoutWidth = 20
        //        self.countLabel.text = count
        //        self.isHeightCalculated = false
        //        self.setNeedsLayout()
        //        self.layoutIfNeeded()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
