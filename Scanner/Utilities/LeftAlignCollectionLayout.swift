//
//  LeftAlignCollectionLayout.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/18/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var cache: [IndexPath : UICollectionViewLayoutAttributes] = [:]
    
    override func prepare() {
        cache = [:]
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var attributes = originalAttributes.map { $0.copy() as! UICollectionViewLayoutAttributes }
        var attributesByGraphicalRow: [[UICollectionViewLayoutAttributes]] = []
        var y: CGFloat = 0
        var currentRow: [UICollectionViewLayoutAttributes] = []
        
        func changeAttributesOfRow(_ row: [UICollectionViewLayoutAttributes]) {
            var minX: CGFloat = 0
            
            for rowAttribute in currentRow {
                let oldFrame = rowAttribute.frame
                let newOrigin = CGPoint(x: minX, y: oldFrame.origin.y)
                let newFrame = CGRect(origin: newOrigin, size: oldFrame.size)
                rowAttribute.frame = newFrame
                minX += (newFrame.size.width + self.minimumInteritemSpacing)
            }
        }
        
        for attribute in attributes {
            if attribute.frame.origin.y > y {
                // new row starts
                changeAttributesOfRow(currentRow)
                attributesByGraphicalRow.append(currentRow)
                currentRow = []
                y = attribute.frame.origin.y
            }
            currentRow.append(attribute)
        }
        if currentRow.count > 0 {
            // last row isn't appended in for loop
            changeAttributesOfRow(currentRow)
            attributesByGraphicalRow.append(currentRow)
        }
        
        for attribute in attributes {
            cache[attribute.indexPath] = attribute
        }
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attribute = cache[indexPath] {
            return attribute
        }
        // now what??
        return super.layoutAttributesForItem(at: indexPath)
    }
}
