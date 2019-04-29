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
    
    var tags: [ItemModel] = []
    var empty: ItemModel = ListFiles.TagModel.empty()
    var cellIdentifier: String = ""
    
    
    
    init(cellID: String, emptyData: ItemModel) {
        self.cellIdentifier = cellID
        self.empty = emptyData
    }
    
    
}
extension TagCollectionSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag != 1 {
            return self.tags.count
            
        } 
        return self.tags.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if indexPath.item >= self.tags.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! DefaultDisplayableCell
            cell.setCell(model: self.empty)
            return cell
            
//            if collectionView.tag == 1 {
//
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! DefaultDisplayableCell
//                cell.setCell(name: "", count: "0", color: UIColor.clear)
//                return cell
//            } else if collectionView.tag == 3 {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowTagsCollectionViewCell.identifier, for: indexPath) as! ShowTagsCollectionViewCell
//                cell.setCell(name: "", count: "0", color: UIColor.clear)
//                return cell
//            } else  {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionViewCell.identifier, for: indexPath) as! FolderCollectionViewCell
//                cell.setCell(name: "")
//                return cell
//            }
        }
        let tag = self.tags[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! DefaultDisplayableCell
        cell.setCell(model: tag)
        return cell
//        if collectionView.tag == 1 {
//            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTagCollectionViewCell.identifier, for: indexPath) as! MainTagCollectionViewCell
//            cell.setCell(name: tag.name, count: tag.count, color: tag.color)
//            return cell
//        } else if collectionView.tag == 3 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowTagsCollectionViewCell.identifier, for: indexPath) as! ShowTagsCollectionViewCell
//            cell.setCell(name: tag.name, count: tag.count, color: tag.color)
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionViewCell.identifier, for: indexPath) as! FolderCollectionViewCell
//            cell.setCell(name: tag.name)
//            return cell
//        }
        
        
        
        
    }
    
}
extension TagCollectionSource: UICollectionViewDelegate {
    
}
