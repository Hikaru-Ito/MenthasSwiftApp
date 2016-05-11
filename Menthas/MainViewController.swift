//
//  MainViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/11.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import PagingMenuController

class MainViewController: UIViewController, PagingMenuControllerDelegate {
    
    var BaseBGColor: UIColor = UIColor.hexStr("273646", alpha: 1)
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // NavigationBar Hidden
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // StatusBar Background
        let statusBar = UIView(frame:CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
        statusBar.backgroundColor = BaseBGColor
        view.addSubview(statusBar)
        
        // MARK: Configure SwipeTabUI
        for category in categories {
            let feedsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FeedsViewController") as! FeedsViewController
            feedsTableViewController.title = category["name"]
            feedsTableViewController.categoryIdentifier = category["identifier"]
            
            viewControllers.append(feedsTableViewController)
        }
        let options = PagingMenuOptions()
        options.menuHeight   =   54
        options.font         =   UIFont.systemFontOfSize(14, weight: UIFontWeightMedium)
        options.selectedFont =   UIFont.systemFontOfSize(14, weight: UIFontWeightMedium)
        options.menuItemMargin = 18
        options.backgroundColor = BaseBGColor
        options.selectedBackgroundColor = BaseBGColor
        options.textColor = UIColor.hexStr("7f8c8d", alpha: 1)
        options.selectedTextColor = UIColor.hexStr("ffffff", alpha: 1)
        //options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
        options.menuDisplayMode = .Infinite(widthMode: .Flexible, scrollingMode: .ScrollEnabledAndBouces)
        options.menuItemMode = .Underline(height: 3, color: UIColor.whiteColor(), horizontalPadding: 12, verticalPadding: 10)
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func willMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
        
    }
    
    func didMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
        // Tapping StatusBar to Scroll Top Function
        if let pagingMenuController = self.childViewControllers.first as? PagingMenuController {
            for controller in pagingMenuController.visiblePagingViewControllers {
                for subview in controller.view.subviews {
                    if let scrollView = subview as? UIScrollView {
                        scrollView.scrollsToTop = false
                    }
                }
            }
            for subview in menuController.view.subviews {
                if let scrollView = subview as? UIScrollView {
                    scrollView.scrollsToTop = true
                }
            }
        }
    }

}
