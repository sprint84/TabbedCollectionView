//
//  TabbedCollectionView.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

public protocol TabbedCollectionViewDataSource: class {
    func collectionView(collectionView: TabbedCollectionView, numberOfItemsInTab tab: Int) -> Int
    func collectionView(collectionView: TabbedCollectionView, titleForItemAtIndexPath indexPath: NSIndexPath) -> String
    func collectionView(collectionView: TabbedCollectionView, imageForItemAtIndexPath indexPath: NSIndexPath) -> UIImage
    func collectionView(collectionView: TabbedCollectionView, colorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor
    func collectionView(collectionView: TabbedCollectionView, titleColorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor
    func collectionView(collectionView: TabbedCollectionView, backgroundColorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor
}

public protocol TabbedCollectionViewDelegate: class {
    func collectionView(collectionView: TabbedCollectionView, didSelectItemAtIndex index: Int, forTab tab: Int)
}

@IBDesignable public class TabbedCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var view: UIView!
    private let tabWidth = 80.0
    private let tabHeight = 32.0
    private var tabsInfo = [ItemInfo]()
    private var buttonTagOffset = 4827
    private var selectedTab = 0
    private var currentPage = 0
    private var cellWidth: CGFloat {
        return collectionView.frame.width / 5.0
    }
    private var cellHeight: CGFloat {
        return collectionView.frame.height / 3.0
    }
    private var userInteracted = false
    private var storedOffset = CGPointZero
    
    @IBOutlet weak var tabsScrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public weak var dataSource: TabbedCollectionViewDataSource?
    public weak var delegate: TabbedCollectionViewDelegate?
    public var selectionColor = UIColor(red:0.9, green:0.36, blue:0.13, alpha:1.0) {
        didSet {
            reloadTabs()
        }
    }
    public var tabTitleColor = UIColor.darkTextColor() {
        didSet {
            reloadTabs()
        }
    }
    public var tabBackgroundColor = UIColor(white: 0.95, alpha: 1.0) {
        didSet {
            reloadTabs()
        }
    }
    
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
    
    public func createTabs(items: [ItemInfo]) {
        tabsInfo = items
        reloadTabs()
    }
    
    public func updateLayout() {
        let layout = HorizontalFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Private functions
    private func loadXib() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        setupCollectionView()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TabbedCollectionView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    private func setupCollectionView() {
        let bundle = NSBundle(forClass: self.dynamicType)
        collectionView.registerClass(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        collectionView.registerNib(UINib(nibName: "ItemCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "ItemCell")
        updateLayout()
        storedOffset = collectionView.contentOffset
    }
    
    private func reloadTabs() {
        let _ = tabsScrollView.subviews.map { $0.removeFromSuperview() }
        var i = 0
        for item in tabsInfo {
            let button = TabButton(title: item.title, image: item.image, color: item.color)
            button.selectionColor = selectionColor
            button.titleColor = tabTitleColor
            button.bgColor = tabBackgroundColor
            button.frame = CGRect(x: (tabWidth * Double(i)), y: 0, width: tabWidth, height: tabHeight)
            button.tag = i + buttonTagOffset
            button.addTarget(self, action: "tabSelected:", forControlEvents: .TouchUpInside)
            if i == selectedTab {
                button.selected = true
            }
            tabsScrollView.addSubview(button)
            i++
        }
        tabsScrollView.contentSize = CGSize(width: Double(i)*tabWidth, height: tabHeight)
    }
    
    func tabSelected(sender: UIButton) {
        // Deselect previous tab
        if let previousSelected = tabsScrollView.viewWithTag(selectedTab + buttonTagOffset) as? UIButton {
            previousSelected.selected = false
        }
        // Select current tab
        sender.selected = true
        selectedTab = sender.tag - buttonTagOffset
        
        // Updated collection view
        collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 10, height: 10), animated: true)
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionView data source methods
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numItems = dataSource?.collectionView(self, numberOfItemsInTab: selectedTab) else {
            return 0
        }
        return numItems
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        cell.selectionColor = selectionColor
        cell.textLabel.text = dataSource?.collectionView(self, titleForItemAtIndexPath: indexPath)
        cell.imageView.image = dataSource?.collectionView(self, imageForItemAtIndexPath: indexPath)
        cell.imageView.tintColor = dataSource?.collectionView(self, colorForItemAtIndexPath: indexPath)
        cell.textLabel.textColor = dataSource?.collectionView(self, titleColorForItemAtIndexPath: indexPath)
        cell.contentView.backgroundColor = dataSource?.collectionView(self, backgroundColorForItemAtIndexPath: indexPath)
        return cell
    }
    
    // MARK: - UICollectionView delegate methods
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.collectionView(self, didSelectItemAtIndex: indexPath.row, forTab: selectedTab)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        userInteracted = true
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            userInteracted = false
            storedOffset = collectionView.contentOffset
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        userInteracted = false
        storedOffset = collectionView.contentOffset
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if !userInteracted {
            collectionView.contentOffset = storedOffset
        }
    }
}
