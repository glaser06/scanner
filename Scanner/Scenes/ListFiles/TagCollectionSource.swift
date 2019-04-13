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
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
extension TagCollectionSource: UICollectionViewDelegate {
    
}
