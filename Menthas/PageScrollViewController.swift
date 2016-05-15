//
//  PageScrollViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/12.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import SwiftyJSON

class PageScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var seg: UISegmentedControl!
    
    var entryUrl: String! = ""
    var entryTitle: String = ""
    var entryThumImageUrl: String! = ""
    var entryDate: String! = ""
    var entryContent: String! = ""
    
    var entry: JSON! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "hoge", style: .Plain, target: nil, action: nil)
        
        self.initScrollContent()
        self.setSegment()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("PageScrollViewController Deinit")
    }
    
    func initScrollContent() {
        let contentVC = self.storyboard?.instantiateViewControllerWithIdentifier("SegmentContentViewController") as! SegmentContentViewController
        let webVC = self.storyboard?.instantiateViewControllerWithIdentifier("SegmentWebViewController") as! SegmentWebViewController
        
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height)
        
        contentVC.view.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.bounds.width,
            height: self.view.bounds.height)
        contentVC.view.tag = 20
        contentVC.entry = entry
        self.addChildViewController(contentVC)
        self.scrollView.addSubview(contentVC.view)
        contentVC.didMoveToParentViewController(self)
        
        webVC.view.frame = CGRect(
            x: self.view.bounds.width,
            y: 0,
            width: self.view.bounds.width,
            height: self.view.bounds.height)
        webVC.view.tag = 40
        webVC.url = entry["page"]["url"].string ?? ""
        self.addChildViewController(webVC)
        self.scrollView.addSubview(webVC.view)
        webVC.didMoveToParentViewController(self)
        
        self.scrollView.delegate = self
        self.scrollView.scrollsToTop = false
    }
    
    func setSegment() {
        seg = UISegmentedControl(items: ["Smart", "Web"])
        seg.frame = CGRectMake(0, 0, 160, 30)
        seg.center = CGPoint(x: self.view.frame.width/2, y: 0)
        //seg.backgroundColor = UIColor.grayColor()
        seg.tintColor = UIColor.hexStr("2abc9d", alpha: 1)
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(PageScrollViewController.segmentChanged), forControlEvents: UIControlEvents.ValueChanged)
        self.navigationItem.titleView = seg
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
            self.switchedView(0)
        case 1:
            self.scrollView.setContentOffset(CGPoint(x:self.view.frame.width, y:0), animated: true)
            self.switchedView(1)
        default:
            break
        }
    }
    
    func switchedView(index: Int) {
        // Scroll to Top Set
        switch index {
        case 0:
            if let sv = self.scrollView.viewWithTag(20)!.subviews[1] as? UIScrollView {
                sv.scrollsToTop = true
            }
            if let wv = self.scrollView.viewWithTag(40)!.subviews[0] as? UIWebView {
                wv.scrollView.scrollsToTop = false
            }
        case 1:
            if let sv = self.scrollView.viewWithTag(20)!.subviews[1] as? UIScrollView {
                sv.scrollsToTop = false
            }
            if let wv = self.scrollView.viewWithTag(40)!.subviews[0] as? UIWebView {
                wv.scrollView.scrollsToTop = true
            }
        default:
            break
        }
    }
}


// MARK: UIScrollViewDelegate

extension PageScrollViewController {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case 0:
            self.seg.selectedSegmentIndex = 0
            self.switchedView(0)
        case self.view.frame.width:
            self.seg.selectedSegmentIndex = 1
            self.switchedView(1)
        default:
            break
        }
    }
}