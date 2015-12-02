//
//  TabButton.swift
//  RFTabbedCollectionView
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

class TabButton: UIButton {
    let bg = UIColor(white: 0.85, alpha: 1.0)
    init() {
        super.init(frame: CGRectZero)
        backgroundColor = bg
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = bg
    }
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                backgroundColor = UIColor(white: 0.7, alpha: 1.0)
            } else {
                backgroundColor = bg
            }
            super.highlighted = newValue
        }
    }
    
    override func drawRect(rect: CGRect) {
        //create the path
        let leftStroke = UIBezierPath()
        leftStroke.lineWidth = 1.0
        leftStroke.moveToPoint(CGPoint(x:rect.origin.x, y:rect.origin.y))
        leftStroke.addLineToPoint(CGPoint(x:rect.origin.x, y:rect.size.height))
        UIColor.whiteColor().setStroke()
        leftStroke.stroke()
        
        let rightStroke = UIBezierPath()
        rightStroke.lineWidth = 1.0
        rightStroke.moveToPoint(CGPoint(x:rect.size.width, y:rect.origin.y))
        rightStroke.addLineToPoint(CGPoint(x:rect.size.width, y:rect.size.height))
        UIColor.darkGrayColor().setStroke()
        rightStroke.stroke()
        
    }
}
