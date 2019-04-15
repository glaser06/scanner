//
//  FolderCollectionTableViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class FolderCollectionTableViewCell: UITableViewCell, DisplayableCell {
    
    static var identifier: String = "FolderCollectionTableCell"
    static var nibName: String = "FolderCollectionTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.folderCollectionView.register(UINib(nibName: FolderCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: FolderCollectionViewCell.identifier)
        let width: CGFloat = 375
        let cellWidth: CGFloat = (width - 16 * 4 ) / 3.0
        (self.folderCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: cellWidth, height: cellWidth+24)
    }
    @IBOutlet weak var folderCollectionView: UICollectionView!
    
    @IBAction func expand() {
        if let f = self.expandCell {
            f()
        }
    }
    
    var expandCell: (() -> Void)?
    
    func setCell(collectionHandler: UICollectionViewDataSource & UICollectionViewDelegate, expandCell: @escaping (() -> Void)) {
        self.expandCell = expandCell
        self.folderCollectionView.tag = 2
        self.folderCollectionView.delegate = collectionHandler
        self.folderCollectionView.dataSource = collectionHandler
        self.folderCollectionView.reloadData()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
