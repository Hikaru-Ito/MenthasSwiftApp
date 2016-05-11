//
//  WebViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/10.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import BusyNavigationBar

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    var url: String!
    var titie: String!
    var loadingBarOption = BusyNavigationBarOptions()
    
    override func viewDidLoad() {
        self.titie = title
        let targetURL = NSURL(string: url)
        let req = NSURLRequest(URL: targetURL!)
        webView.loadRequest(req)
        webView.delegate = self
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    // Loading BusyNavBar
    func webViewDidStartLoad(webView: UIWebView) {
        loadingBarOption.animationType = .Stripes
        self.navigationController?.navigationBar.start(loadingBarOption)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if !webView.loading {
            self.navigationController?.navigationBar.stop()
        }
    }
}
