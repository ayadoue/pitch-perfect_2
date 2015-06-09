//
//  ViewController.swift
//  Click Counter
//
//  Created by Ayako Doue on 6/5/15.
//  Copyright (c) 2015 aya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    @IBOutlet var label:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
        // Add Label to the UI
        var label = UILabel()
        label.frame = CGRectMake(150, 150, 60, 60)
        label.text = "0"
        self.view.addSubview(label)
        self.label = label
        
        // Add button
        var button = UIButton()
        button.frame = CGRectMake(150, 250, 60, 60)
        button.setTitle("Click", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.addSubview(button)
        
        //button.addTarget(self, action: "incrementCount", forControlEvents: UIControlEvents.TouchUpInside)
        button.addTarget(self, action: "incrementCount", forControlEvents: UIControlEvents.TouchUpInside)

        */
    }
    
    @IBAction func incrementCount() {
        self.count++
        self.label.text = "\(self.count)"
    }
    
}

