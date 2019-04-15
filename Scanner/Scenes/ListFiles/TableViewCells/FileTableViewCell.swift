//
//  FileTableViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell, DisplayableCell {
    
    static var identifier: String = "FileTableCell"
    static var nibName: String = "FileTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pageImage: UIImageView!
    
    func setCell(file: File) {
        self.nameLabel.text = file.name
        self.dateLabel.text = DatePresenter.fullDateString(date: file.date)
        self.pageImage.image = file.cacheImage!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
