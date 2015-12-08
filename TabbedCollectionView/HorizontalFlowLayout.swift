//
//  HorizontalFlowLayout.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/6/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

class HorizontalFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .Horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollDirection = .Horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAttributes = super.layoutAttributesForElementsInRect(rect)
        let verticalItemsCount = Int(floor(self.collectionView!.bounds.size.height / self.itemSize.height))
        let horizontalItemsCount = Int(floor(self.collectionView!.bounds.size.width / self.itemSize.width))
        let itemsPerPage = verticalItemsCount * horizontalItemsCount
        
        var newAttributesInRect = [UICollectionViewLayoutAttributes]()
        for var i = 0; i < allAttributes!.count; i++ {
            let attributes = allAttributes![i]
            let nattr = attributes.copy() as! UICollectionViewLayoutAttributes
            let currentPage = Int(floor(Double(i) / Double(itemsPerPage)))
            let currentRow = Int(floor(Double(i - currentPage * itemsPerPage) / Double(horizontalItemsCount)))
            let currentColumn = i % horizontalItemsCount
            var frame = attributes.frame
            frame.origin.x = self.itemSize.width * CGFloat(currentColumn) + CGFloat(currentPage) * self.collectionView!.bounds.size.width
            frame.origin.y = self.itemSize.height * CGFloat(currentRow)
            nattr.frame = frame
            newAttributesInRect.append(nattr)
            if currentColumn == 3 && currentRow == 2 {
                print(frame)
            }
        }
        return newAttributesInRect
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        let size = super.collectionViewContentSize()
        let collectionViewWidth = self.collectionView!.frame.size.width
        let nbOfScreens = Int(ceil(size.width / collectionViewWidth))
        let newSize = CGSize(width: CGFloat(nbOfScreens) * collectionViewWidth, height: size.height)
        return newSize
    }
}