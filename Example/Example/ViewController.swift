//
//  ViewController.swift
//  Example
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit
import RFTabbedCollectionView

class ViewController: UIViewController {
    @IBOutlet weak var tabbedCollectionView: RFTabbedCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let titles = ["Home", "Shopping", "Health", "Car and Transport", "Education", "Pets", "Leisure", "Phone", "Computer", "Other"]
        let images = [UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!,
            UIImage(named: "globe_icon")!]
        tabbedCollectionView.createTabs(titles, images: images)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

