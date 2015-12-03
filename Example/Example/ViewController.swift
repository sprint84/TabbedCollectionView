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
        
        let info = ["Home": UIImage(named: "globe_icon")!,
            "Shopping": UIImage(named: "globe_icon")!,
            "Health": UIImage(named: "globe_icon")!,
            "Car and Transport": UIImage(named: "globe_icon")!,
            "Education": UIImage(named: "globe_icon")!,
            "Pets": UIImage(named: "globe_icon")!,
            "Leisure": UIImage(named: "globe_icon")!,
            "Phone": UIImage(named: "globe_icon")!,
            "Computer": UIImage(named: "globe_icon")!,
            "Other": UIImage(named: "globe_icon")!]
        tabbedCollectionView.createTabs(info)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

