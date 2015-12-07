//
//  HorizontalFlowLayout.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/6/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

class HorizontalFlowLayout: UICollectionViewFlowLayout {
    var nbColumns: Int
    var nbLines: Int
    override init() {
        nbColumns = -1
        nbLines = -1
        super.init()
        self.scrollDirection = .Horizontal
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        nbColumns = -1
        nbLines = -1
        super.init(coder: aDecoder)
        self.scrollDirection = .Horizontal
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let columns = self.nbColumns != -1 ? self.nbColumns : Int(self.collectionView!.frame.size.width/self.itemSize.width)
        let lines = self.nbLines != -1 ? self.nbLines : Int(self.collectionView!.frame.size.height/self.itemSize.height)
        let idxPage = indexPath.row/(columns * lines)
        
        let L = indexPath.row - (idxPage * columns * lines)
        
        let xD = L / columns
        let yD = L % columns
        
        let D = xD + yD * lines + idxPage * columns * lines
        let fakeIndexPath = NSIndexPath(forItem: D, inSection: indexPath.section)

        let attributes = super.layoutAttributesForItemAtIndexPath(fakeIndexPath)
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let newX = min(0, rect.origin.x - rect.size.width/2)
        let newWidth = rect.size.width * 2 + (rect.origin.x - newX)
        
        let newRect = CGRect(x: newX, y: rect.origin.y, width: newWidth, height: rect.size.height)
        
        let allAttributesInRect = super.layoutAttributesForElementsInRect(newRect)
        var newAttributesInRect = [UICollectionViewLayoutAttributes]()
        for attr in allAttributesInRect! {
            let newAttr = self.layoutAttributesForItemAtIndexPath(attr.indexPath)
            let nattr = attr.copy() as! UICollectionViewLayoutAttributes
            nattr.frame = newAttr!.frame
            nattr.center = newAttr!.center
            nattr.bounds = newAttr!.bounds
            nattr.hidden = newAttr!.hidden
            nattr.size = newAttr!.size
            newAttributesInRect.append(nattr)
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