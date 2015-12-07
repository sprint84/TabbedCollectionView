//
//  ItemInfo.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/7/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

@objc public protocol ItemInfo {
    var title: String { get set }
    var image: UIImage { get set }
    var color: UIColor { get set }
}