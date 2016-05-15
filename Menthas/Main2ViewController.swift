//
//  Main2ViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/15.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import TabPageViewController

class Main2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tc = TabPageViewController.create()
        
        for category in categories {
            let feedsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FeedsViewController") as! FeedsViewController
            feedsTableViewController.title = category["name"]
            feedsTableViewController.categoryIdentifier = category["identifier"]
            
            tc.tabItems.append((feedsTableViewController, category["name"]!))
        }
        
        tc.isInfinity = true
        var option = TabPageOption()
        option.currentColor = UIColor.hexStr("2abc9d", alpha: 1)
        tc.option = option
        self.addChildViewController(tc)
        self.view.addSubview(tc.view)
        tc.didMoveToParentViewController(self)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
