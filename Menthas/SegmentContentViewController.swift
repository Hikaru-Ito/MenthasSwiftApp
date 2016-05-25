//
//  SegmentContentViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/12.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import SafariServices
import SwiftyJSON
import WebImage

class SegmentContentViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateTextView: UILabel!
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var topImageView: UIImageView!
    
    var entry:JSON! = [] {
        didSet {
            self.setContent()
            self.loadEntryContent()
        }
    }
    
    @IBAction func pushButtonTouched(sender: AnyObject) {
        let url = entry["page"]["url"].string ?? ""
        let vc = SFSafariViewController(URL: NSURL(string: url)!)
        presentViewController(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // ScrollView Padding
        let edgeInsets = ViewManager.navigationBarHeight + ViewManager.statusBarHeight
        scrollView.contentInset.top = edgeInsets
        scrollView.scrollIndicatorInsets.top = edgeInsets
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("Content deinit")
    }

    func loadEntryContent() {
        FeedsService.articleContent(entry["page"]["url"].string ?? "") { (JSON) -> () in
            print(JSON["content"].string ?? "")
            self.setArticleContent(JSON["content"].string ?? "")
        }
    }
    
    func setArticleContent(htmlStr: String) {
        do {
            let htmlData = htmlStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!
            let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
            textView.attributedText = attributedText
        } catch {
            print(error)
        }
        let size = textView.sizeThatFits(textView.frame.size)
        textView.frame.size.height = size.height
    }
    
    func setContent() {
        topImageView.sd_setImageWithURL(NSURL(string: entry["page"]["thumbnail"].string ?? ""))
        topImageView.contentMode = UIViewContentMode.Redraw
        titleTextView.text = entry["page"]["title"].string ?? ""
        textView.text = entry["page"]["description"].string ?? ""
        let size = textView.sizeThatFits(textView.frame.size)
        textView.frame.size.height = size.height
    }
    
    // MARK: UIScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let edgeInsets = ViewManager.navigationBarHeight + ViewManager.statusBarHeight
        let offset = scrollView.contentOffset.y + edgeInsets
        var imageTransform = CATransform3DIdentity
        
        if offset < 0 {
            let imageScaleFactor:CGFloat = -(offset) / topImageView.bounds.height
            let imageSizevariation = ((topImageView.bounds.height * (1.0 + imageScaleFactor)) - topImageView.bounds.height)
            
            imageTransform = CATransform3DTranslate(imageTransform, 0, -(imageSizevariation / 2), 0)
            imageTransform = CATransform3DScale(imageTransform, 1.0 + imageScaleFactor, 1.0 + imageScaleFactor, 0)
            
            topImageView.layer.transform = imageTransform
        }
    }
    
}
