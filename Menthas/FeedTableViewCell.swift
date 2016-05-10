//
//  FeedTableViewCell.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/10.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import WebImage
import SwiftyJSON

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!

    // MARK: Congigure Cell Contents
    func configureWithFeed(feed: JSON) {
        let title = feed["page"]["title"].string ?? ""
        let category = feed["category"]["title"].string ?? ""
        let thum_image_url = feed["page"]["thumbnail"].string ?? ""
        
        titleLabel.text = title
        categoryLabel.text = category
        thumImageView.sd_setImageWithURL(NSURL(string: thum_image_url))
        thumImageView.contentMode = UIViewContentMode.Redraw
    }
}
