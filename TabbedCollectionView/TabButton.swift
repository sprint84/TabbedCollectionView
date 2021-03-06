//
//  TabButton.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

class TabButton: UIButton {
    var bgColor = UIColor(white: 0.95, alpha: 1.0) {
        didSet {
            backgroundColor = bgColor
        }
    }
    var selectionColor = UIColor(red:0.9, green:0.36, blue:0.13, alpha:1)
    var titleColor = UIColor.darkTextColor() {
        didSet {
            buildAttributedTitle()
        }
    }
    private var title = ""
    private var image = UIImage()
    private var attributedTitle = NSAttributedString()
    
    init(title: String, image: UIImage, color: UIColor) {
        self.title = title
        self.image = image
        super.init(frame: CGRectZero)
        buildAttributedTitle()
        backgroundColor = bgColor
        tintColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = bgColor
    }
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue || selected {
                backgroundColor = UIColor(white: 0.87, alpha: 1.0)
            } else {
                backgroundColor = bgColor
            }
            super.highlighted = newValue
        }
    }
    
    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            if newValue {
                backgroundColor = UIColor(white: 0.87, alpha: 1.0)
            } else {
                backgroundColor = bgColor
            }
            super.selected = newValue
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        if selected {
            let underscore = UIBezierPath()
            underscore.lineWidth = 3.0
            underscore.moveToPoint(CGPoint(x:rect.origin.x, y:rect.size.height))
            underscore.addLineToPoint(CGPoint(x:rect.size.width, y:rect.size.height))
            selectionColor.setStroke()
            underscore.stroke()
        }
        
        let imageFrame = CGRect(x: rect.width/2.0 - 8.0, y: 3, width: 16, height: 16)
        self.tintColor.setFill()
        image.drawInRect(imageFrame)
        
        let textFrame = CGRect(x: 4, y: 20, width: rect.width - 8, height: 14)
        attributedTitle.drawInRect(textFrame)
    }
    
    func buildAttributedTitle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        paragraphStyle.lineBreakMode = .ByTruncatingMiddle
        let attributes: [String: AnyObject] = [NSForegroundColorAttributeName: titleColor,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 8)!,
            NSParagraphStyleAttributeName: paragraphStyle]
        self.attributedTitle = NSAttributedString(string: title, attributes: attributes)
    }
}
