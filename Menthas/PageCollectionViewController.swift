//
//  PageCollectionViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/12.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

struct Pages {
    var viewControllers:[UIViewController] = []
}

class PageCollectionViewController: UICollectionViewController {
    
    var pages:Pages = Pages(){
        didSet { self.collectionView?.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "PageCollectionViewCell")
        
        let segmentContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SegmentContentViewController") as! SegmentContentViewController
        self.pages.viewControllers.append(segmentContentViewController)
        
        let segmentWebViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SegmentWebViewController") as! SegmentWebViewController
        self.pages.viewControllers.append(segmentWebViewController)
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pages.viewControllers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PageCollectionViewCell", forIndexPath: indexPath) as UICollectionViewCell
        let view = self.pages.viewControllers[indexPath.row].view
        cell.contentView.addSubview(view)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let pageViewRect = self.view.bounds
        return CGSize(width: pageViewRect.width, height: pageViewRect.height - 64)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
}