//
//  TopicContentViewController.swift
//  MyV2ex
//
//  Created by wangchi on 15/4/22.
//  Copyright (c) 2015年 wangchi. All rights reserved.
//

import UIKit
import SwiftyJSON


class TopicContentViewController: UITableViewController {
  
    var data : JSON!
    var replySource : Array<JSON>?

  
  

    override func viewDidLoad() {
     
        super.viewDidLoad()
        let topicCellNib = UINib(nibName: "TopicBodyCell", bundle: nil)
        tableView.registerNib(topicCellNib, forCellReuseIdentifier: "TopicBodyCell")
      
        let topicTitleNib = UINib(nibName: "TopicTitleCell", bundle: nil)
        tableView.registerNib(topicTitleNib, forCellReuseIdentifier: "TopicTitleCell")
      
        let replyCellNib = UINib(nibName: "ReplyCell", bundle: nil)
        tableView.registerNib(replyCellNib, forCellReuseIdentifier: "ReplyCell")

      
        tableView.separatorColor = UIColor.clearColor()
        fetchData()
  
      


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  

  func fetchData() {
    let TopicID = data["id"].stringValue as NSString
    APIClient.sharedInstance.getRepliesForTopic(TopicID, success: { (json) -> Void in
      if json.type == Type.Array {
        self.replySource = json.arrayValue
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          var indexPaths = Array<NSIndexPath>()
          for i in 0...self.replySource!.count {
            let indexpath = NSIndexPath(forRow: i + 2, inSection: 0)
            indexPaths.append(indexpath)
          }
          self.tableView.reloadData()
        
        })

      }
    }) { (error) -> Void in
      
    }
    
  }
  
 

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      if let reply = replySource {
        return reply.count + 2
      } else {
        return 2
      }
    }
  


  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicBodyCell") as! TopicBodyCell
        cell.contentLabel.text = data["content"].stringValue

        return cell
      } else if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicTitleCell") as! TopicTitleCell
        let imageUrlString = "http:" + data["member"]["avatar_mini"].stringValue
        let imageUrl = NSURL(string: imageUrlString)
        cell.avatarView.kf_setImageWithURL(imageUrl!)
        cell.titleLabel.text = data["title"].stringValue
        cell.replyNumLabel.text = data["replies"].stringValue + "个回复"
        cell.timeLabel.text = data["created"].stringValue
        cell.authorLabel.text = data["member"]["username"].stringValue
        
        return cell
        
        
        
        
      } else {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReplyCell") as! ReplyCell
        
        if let replyArray = replySource {
          let reply = replyArray[indexPath.row - 2]
          cell.contentLabel.text = reply["content"].stringValue
          let imageUrlString = "http:" + reply["member"]["avatar_large"].stringValue
          let imageUrl = NSURL(string: imageUrlString)
          cell.avatarView.kf_setImageWithURL(imageUrl!)
          cell.authorLabel.text = reply["member"]["username"].stringValue
          cell.timeLabel.text = reply["created"].stringValue
        }
  
        
        return cell
        
      }
    
    }
  
  override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCellWithIdentifier("TopicBodyCell") as! TopicBodyCell
  
      return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    } else if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("TopicTitleCell") as! TopicTitleCell
      return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("ReplyCell") as! ReplyCell
      return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    }
    
  }

  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
