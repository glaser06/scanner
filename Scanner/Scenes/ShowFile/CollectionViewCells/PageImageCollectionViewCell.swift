//
//  PageImageCollectionViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/11/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class PageImageCollectionViewCell: UICollectionViewCell, DisplayableCell {
    
    static var identifier: String = ""
    static var nibName: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imageView: UIImageView!
    
    func setCell(image: UIImage) {
        
    }

}
