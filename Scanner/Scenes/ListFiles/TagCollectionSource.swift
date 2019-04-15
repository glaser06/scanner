//
//  TagCollectionSource.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/10/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit

class TagCollectionSource: NSObject {
    
    var tags: [ListFiles.TagModel] = []
    
    
    
    
}
extension TagCollectionSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tag = self.tags[indexPath.item]
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTagCollectionViewCell.identifier, for: indexPath) as! MainTagCollectionViewCell
            cell.setCell(name: tag.name, count: tag.count, color: tag.color)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionViewCell.identifier, for: indexPath) as! FolderCollectionViewCell
            cell.setCell(name: tag.name)
            return cell
        }
        
        
        
        
    }
    
}
extension TagCollectionSource: UICollectionViewDelegate {
    
}
