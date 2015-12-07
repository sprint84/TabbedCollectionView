//
//  ItemCollectionViewCell.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/3/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    var selectionColor = UIColor(red:0.9, green:0.36, blue:0.13, alpha:1.0)
    lazy var selectionView = UIView()
    lazy var indicatorView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            if newValue {
                selectionView.frame = self.bounds
                selectionView.backgroundColor = selectionColor
                selectionView.alpha = 0.2
                indicatorView.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
                indicatorView.backgroundColor = selectionColor
                self.addSubview(selectionView)
                self.addSubview(indicatorView)
            } else {
                selectionView.removeFromSuperview()
                indicatorView.removeFromSuperview()
            }
            super.selected = newValue
        }
    }
}
