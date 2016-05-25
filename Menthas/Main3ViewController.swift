//
//  Main3ViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/15.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

/*
 
    SwipetabUIを独自実装するときのためのClass
    SwipeしてContents遷移させるところまで実装
 
*/

class Main3ViewController: UIPageViewController {

    
    var screens: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIPageViewのデータソースを設定
        self.dataSource = self
        
        // AutoLayoutを解除
        self.automaticallyAdjustsScrollViewInsets = false
        
        for category in categories {
            let feedsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FeedsViewController") as! FeedsViewController
            feedsTableViewController.title = category["name"]
            feedsTableViewController.categoryIdentifier = category["identifier"]
            
            screens.append(feedsTableViewController)
        }
        
        setViewControllers([screens[0]],
                           direction: .Forward,
                           animated: true,
                           completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension Main3ViewController: UIPageViewControllerDataSource {
    
    func calcScreen(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
    
        guard var index = screens.indexOf(viewController) else {
            return nil
        }
        
        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        if index < 0 {
            index = screens.count - 1
        } else if index == screens.count {
            index = 0
        }
        
        if index >= 0 && index < screens.count {
            return screens[index]
        }
        
        return nil
    }
    
    
    // 逆方向にページ送りした時に呼ばれるメソッド
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return calcScreen(viewController, isAfter: false)
    }
    
    // 順方向にページ送りした時に呼ばれるメソッド
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return calcScreen(viewController, isAfter: true)
    }
}