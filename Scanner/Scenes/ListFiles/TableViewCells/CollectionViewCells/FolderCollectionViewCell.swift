//
//  FolderCollectionViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: DefaultDisplayableCell {
    
    
    override class var identifier: String {
        return "FolderCell"
    }
    override class var nibName: String {
        return "FolderCollectionViewCell"
    }
//    static let identifier: String = "FolderCell"
//    static let nibName: String = "FolderCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    override func setCell(model: ItemModel) {
        if let folder = model as? ListFiles.FolderModel {
            self.setCell(folderModel: folder)
        }
    }
    
    func setCell(folderModel: ListFiles.FolderModel) {
        let imageArray = [image1, image2, image3, image4]
        for (i, img) in imageArray.enumerated() {
            imageArray[i]?.image = UIImage()
        }
        self.nameLabel.text = folderModel.name
        for (i, item) in folderModel.images.enumerated() {
            if i == imageArray.count {
                break 
            }
            imageArray[i]?.image = item
        }
        
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
