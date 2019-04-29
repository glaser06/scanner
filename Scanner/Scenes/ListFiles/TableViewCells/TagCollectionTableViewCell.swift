//
//  TagCollectionTableViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class TagCollectionTableViewCell: UITableViewCell, DisplayableCell {
    
    static var identifier: String = "TagCollectionTableCell"
    static var nibName: String = "TagCollectionTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let collectionViewFlowLayout = self.tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
                        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 44, height: 40)
//            collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
        }
        self.tagCollectionView.register(UINib(nibName: MainTagCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MainTagCollectionViewCell.identifier)
    }
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBAction func routeToShowTags() {
        self.showTags()
    }
    
    var showTags: (() -> Void)!
    
    func setCell(collectionHandler: UICollectionViewDataSource & UICollectionViewDelegate, routeToShowTags: @escaping (() -> Void)) {
        self.tagCollectionView.tag = 1
        self.tagCollectionView.delegate = collectionHandler
        self.tagCollectionView.dataSource = collectionHandler
        self.tagCollectionView.reloadData()
        self.showTags = routeToShowTags
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
