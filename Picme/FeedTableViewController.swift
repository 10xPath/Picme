//
//  FeedTableViewController.swift
//  Picme
//
//  Created by John Nguyen on 4/5/15.
//  Copyright (c) 2015 John Nguyen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedTableViewController:PFQueryTableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!

    
//    override init!(style: UITableViewStyle, className: String!) {
//        super.init(style: style, className: className)
//    }
//    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Event"
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 3
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        loadObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func objectsDidLoad(error: NSError!) {
        super.objectsDidLoad(error)
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
        if(indexPath.section < self.objects!.count){
            return self.objects![indexPath.section] as? PFObject
        }else{
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == self.objects!.count){
            return nil
        }
        let sectionHeaderView : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! UITableViewCell
        
        let profileImageView : PFImageView = sectionHeaderView.viewWithTag(1) as! PFImageView
        let usernameLabel : UILabel = sectionHeaderView.viewWithTag(2) as! UILabel
        let titleLabel : UILabel = sectionHeaderView.viewWithTag(3) as! UILabel
        let voteLabel : UILabel = sectionHeaderView.viewWithTag(4) as! UILabel
        
        let event : PFObject = self.objects![section] as! PFObject
        let user : PFUser = event["Host"] as! PFUser
        let profilePicture:PFFile = user["profileImage"] as! PFFile
        let vote : NSInteger = event["Votes"] as! NSInteger
        let title : NSString = event["Title"] as! NSString
        
        usernameLabel.text = user.username
        titleLabel.text = title as String
        profileImageView.file = profilePicture
        voteLabel.text = String(vote)
        profileImageView.loadInBackground(nil)
        
        return sectionHeaderView
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: (UITableView!), cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        if(indexPath.section == self.objects!.count){
            var cell:PFTableViewCell = self.tableView(tableView, cellForNextPageAtIndexPath: indexPath)!
            return cell
        }else{
            let imageCell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PFTableViewCell
            
            let eventImageView : PFImageView = imageCell.viewWithTag(1) as! PFImageView
            eventImageView.file = object.objectForKey("Image") as? PFFile
            
            
            eventImageView.loadInBackground(nil)
            
            return imageCell
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sections:NSInteger = self.objects!.count
        if(self.paginationEnabled && sections > 0){
            sections++
        }
        return sections
        
    }
    
    override func _indexPathForPaginationCell() -> NSIndexPath {
        return NSIndexPath(forRow: 0, inSection: self.objects!.count)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == self.objects!.count){
            return 0
        }
        return 50.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == self.objects!.count){
            return 0
        }
        return 50.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == self.objects!.count){
            return 50.0
        }
        return 320.0
    }
    
    override func tableView(tableView: UITableView, cellForNextPageAtIndexPath indexPath: (NSIndexPath!)) -> PFTableViewCell? {
        var loadMoreCell = tableView.dequeueReusableCellWithIdentifier("LoadMoreCell") as! PFTableViewCell
        return loadMoreCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == self.objects!.count && self.paginationEnabled){
            self.loadNextPage()
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableCellWithIdentifier("FooterView") as! UITableViewCell
        
        return footerView
    }
    
    
    override func queryForTable() -> PFQuery {
        let query: PFQuery = PFQuery(className: self.parseClassName!)
        query.includeKey("Host")
        query.orderByDescending("createdAt")
        return query
    }
}
