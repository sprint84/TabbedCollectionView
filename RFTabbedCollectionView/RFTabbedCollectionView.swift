//
//  RFTabbedCollectionView.swift
//  RFTabbedCollectionView
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

@IBDesignable
public class RFTabbedCollectionView: UIView {
    var view: UIView!
    private let tabWidth = 64.0
    private var tabs: [UIImage] = []
    @IBOutlet weak var tabsScrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func tabIcons(icons: [UIImage]) {
        tabs = icons
        reloadTabs()
    }
    
    // MARK: - Private functions
    private func loadXib() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "RFTabbedCollectionView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    private func reloadTabs() {
        let _ = self.tabsScrollView.subviews.map { $0.removeFromSuperview() }
        var i = 0.0
        for image in tabs {
            let button = TabButton()
            button.frame = CGRect(x: (tabWidth * i), y: 0, width: tabWidth, height: 40)
            button.setImage(image, forState: .Normal)
            layoutTabButton(button)
            self.tabsScrollView.addSubview(button)
            i++
            
            button.tintColor = UIColor(red: 1.0, green: 1.0 - CGFloat(i)/10.0, blue: 1.0 - CGFloat(i)/10.0, alpha: 1.0)
            
        }
        self.tabsScrollView.contentSize = CGSize(width: i*tabWidth, height: 40)
    }
    
    private func layoutTabButton(button: UIButton) {
//        let image = imageWithColor(UIColor(white: 0.8, alpha: 1.0))
//        button.setBackgroundImage(image, forState: .Normal)
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
}
