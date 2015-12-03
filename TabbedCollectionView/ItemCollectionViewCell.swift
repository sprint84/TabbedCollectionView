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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
