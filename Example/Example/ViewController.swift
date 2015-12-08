//
//  ViewController.swift
//  Example
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit
import TabbedCollectionView

class Item: ItemInfo {
    @objc var title: String = ""
    @objc var image: UIImage = UIImage()
    @objc var color = UIColor.blackColor()
}

class ViewController: UIViewController, TabbedCollectionViewDataSource, TabbedCollectionViewDelegate {
    @IBOutlet weak var tabbedCollectionView: TabbedCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabs = buildTabs()
        tabbedCollectionView.createTabs(tabs)
        tabbedCollectionView.dataSource = self
        tabbedCollectionView.delegate = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        tabbedCollectionView.updateLayout()
    }
    
    func buildTabs() -> [Item] {
        let home = Item()
        home.title = "Home"
        home.image = UIImage(named: "globe_icon")!
        home.color = UIColor.redColor()
        
        let shop = Item()
        shop.title = "Shopping"
        shop.image = UIImage(named: "globe_icon")!
        shop.color = UIColor.cyanColor()
        
        let health = Item()
        health.title = "Health"
        health.image = UIImage(named: "globe_icon")!
        health.color = UIColor.orangeColor()
        
        let car = Item()
        car.title = "Car and Transport"
        car.image = UIImage(named: "globe_icon")!
        car.color = UIColor.greenColor()
        
        let edu = Item()
        edu.title = "Education"
        edu.image = UIImage(named: "globe_icon")!
        edu.color = UIColor.purpleColor()
        
        let pets = Item()
        pets.title = "Pets"
        pets.image = UIImage(named: "globe_icon")!
        pets.color = UIColor.grayColor()
        
        let leisure = Item()
        leisure.title = "Leisure"
        leisure.image = UIImage(named: "globe_icon")!
        leisure.color = UIColor.magentaColor()
        
        let comp = Item()
        comp.title = "Computer"
        comp.image = UIImage(named: "globe_icon")!
        comp.color = UIColor.blueColor()
        
        let other = Item()
        other.title = "Other"
        other.image = UIImage(named: "globe_icon")!
        other.color = UIColor.brownColor()
        
        return [home, shop, health, car, edu, pets, leisure, comp, other]
    }
    
    // MARK: - RFTabbedCollectionView data source methods
    func collectionView(collectionView: TabbedCollectionView, numberOfItemsInTab tab: Int) -> Int {
        return (tab+1)*10
    }

    func collectionView(collectionView: TabbedCollectionView, titleForItemAtIndexPath indexPath: NSIndexPath) -> String {
        return "Item \(indexPath.row)"
    }
    
    func collectionView(collectionView: TabbedCollectionView, imageForItemAtIndexPath indexPath: NSIndexPath) -> UIImage {
        var image: UIImage!
        switch(indexPath.row % 3) {
        case 0:
            image = UIImage(named: "car")
        case 1:
            image = UIImage(named: "computer")
        case 2:
            image = UIImage(named: "home")
        default:
            image = UIImage(named: "car")
        }
        return image
    }
    
    func collectionView(collectionView: TabbedCollectionView, colorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor {
        return UIColor(red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    func collectionView(collectionView: TabbedCollectionView, titleColorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor {
        return UIColor(white: 0.55, alpha: 1.0)
    }
    
    func collectionView(collectionView: TabbedCollectionView, backgroundColorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor {
        return UIColor.whiteColor()
    }

    // MARK: - RFTabbedCollectionView delegate methods
    func collectionView(collectionView: TabbedCollectionView, didSelectItemAtIndex index: Int, forTab tab: Int) {
        print("Selected item: \(index) on tab: \(tab)")
    }
}

