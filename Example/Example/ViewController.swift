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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let view = RFTabbedCollectionView(frame: CGRect(x: 0, y: 100, width: 375, height: 175))
        self.view.addSubview(view)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

