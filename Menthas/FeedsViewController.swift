//
//  FeedsViewController.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/11.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var feeds: JSON! = []
    var categoryName: String! = ""
    var categoryIdentifier: String! = ""
    var refreshControl:UIRefreshControl!
    
    func loadFeeds(category: String, offset: Int) {
        FeedsService.feedsList(category, offset: offset) { (JSON) -> () in
            self.feeds = JSON["items"]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    func refreshFeeds() {
        loadFeeds(categoryIdentifier, offset: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedsViewController.refreshFeeds), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        loadFeeds(categoryIdentifier, offset: 0)
    }

    // MARK: TableView Configure
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as! FeedTableViewCell
        let feed = feeds[indexPath.row]
        cell.configureWithFeed(feed)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("WebSegue", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WebSegue" {
            let toView = segue.destinationViewController as! WebViewController
            let indexPath = sender as! NSIndexPath
            let url = feeds[indexPath.row]["page"]["url"].string ?? ""
            let title = feeds[indexPath.row]["page"]["title"].string ?? ""
            toView.url = url
            toView.title = title
        }
    }
}
