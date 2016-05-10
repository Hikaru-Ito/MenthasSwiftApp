//
//  WebViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/10.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var url: String!
    
    override func viewDidLoad() {
        let targetURL = NSURL(string: url)
        let req = NSURLRequest(URL: targetURL!)
        webView.loadRequest(req)
        
    }
    
    deinit {
        webView.stopLoading()
    }
}
