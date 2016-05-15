//
//  SegmentWebViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/12.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

class SegmentWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var url: String! = ""
    
    override func viewDidLoad() {
        
        // ScrollView Padding
        let edgeInsets = ViewManager.navigationBarHeight + ViewManager.statusBarHeight
        webView.scrollView.contentInset.top = edgeInsets
        webView.scrollView.scrollIndicatorInsets.top = edgeInsets
        
        webView.delegate = self
        webView.scrollView.scrollsToTop = false
    }
    
    override func viewWillAppear(animated: Bool) {
        loadPage()
    }
    func loadPage() {
        let targetURL = NSURL(string: url)
        let req = NSURLRequest(URL: targetURL!)
        webView.loadRequest(req)
        print("load start")
    }
    func stopLoading() {
        if webView.loading {
            webView.stopLoading()
            print("stop loading")
        }
    }
    deinit {
        webView.loadHTMLString("", baseURL: nil)
        webView.delegate = nil
        stopLoading()
        print("Web View deinit")
    }
    
}
