//
//  RFTabbedCollectionView.swift
//  RFTabbedCollectionView
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

@IBDesignable
public class RFTabbedCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var view: UIView!
    private let tabWidth = 72.0
    private var tabsInfo: OrderedDictionary<String, UIImage> = []
    private var buttonTagOffset = 4827
    private var selectedIndex = 0
    private var currentPage = 0
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
    
    public func createTabs(titles: [String], images: [UIImage]) {
        tabsInfo = OrderedDictionary()
        for var i = 0; i < titles.count && i < images.count; i++ {
            tabsInfo[titles[i]] = images[i]
        }
        reloadTabs()
    }
    
    // MARK: - Private functions
    private func loadXib() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "RFTabbedCollectionView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    private func reloadTabs() {
        let _ = self.tabsScrollView.subviews.map { $0.removeFromSuperview() }
        var i = 0
        for (title, image) in tabsInfo {
            let button = TabButton(title: title, image: image)
            button.frame = CGRect(x: (tabWidth * Double(i)), y: 0, width: tabWidth, height: 40)
            button.tag = i + buttonTagOffset
            button.addTarget(self, action: "tabSelected:", forControlEvents: .TouchUpInside)
            if i == selectedIndex {
                button.selected = true
            }
            self.tabsScrollView.addSubview(button)
            
            button.tintColor = UIColor(red: 1.0, green: 1.0 - CGFloat(i)/10.0, blue: 1.0 - CGFloat(i)/10.0, alpha: 1.0)
            
            i++
        }
        self.tabsScrollView.contentSize = CGSize(width: Double(i)*tabWidth, height: 40)
    }
    
    func tabSelected(sender: UIButton) {
        // Deselect previous tab
        if let previousSelected = tabsScrollView.viewWithTag(selectedIndex + buttonTagOffset) as? UIButton {
            previousSelected.selected = false
        }
        // Select current tab
        sender.selected = true
        selectedIndex = sender.tag - buttonTagOffset
        
        // Updated collection view
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionView data source methods
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numItems = 68
        pageControl.numberOfPages = Int(ceil(Double(numItems) / 18.0))
        return numItems
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor(red: CGFloat(Double(random())/4230003001), green: CGFloat(Double(random())/4230003001), blue: CGFloat(Double(random())/4230003010), alpha: 1.0)
        return cell
    }
    
    // MARK: - UICollectionView delegate methods
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected: \(indexPath.section): \(indexPath.row)")
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w = collectionView.frame.width / 6.0
        let h = collectionView.frame.height / 3.0
        return CGSize(width: w, height: h)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let currentPage = collectionView.contentOffset.x / pageWidth
        
        if 0.0 != fmodf(Float(currentPage), 1.0) {
            pageControl.currentPage = Int(currentPage) + 1
        } else {
            pageControl.currentPage = Int(currentPage)
        }
    }
}
