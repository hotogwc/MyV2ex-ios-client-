//
//  ViewController.swift
//  MyV2ex
//
//  Created by wangchi on 15/4/12.
//  Copyright (c) 2015年 wangchi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher



class TopicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


 
  @IBOutlet weak var segControl: HMSegmentedControl!
  @IBOutlet weak var topicTableView: UITableView!
  var refresh: UIRefreshControl!
  
  enum status {
    case Hot
    case All
  }
  
  private var listStatus : status = status.Hot

  var dataSource : Array<JSON>!

  override func viewDidLoad() {
    
    super.viewDidLoad()
    segControl.sectionTitles = ["最热","全部"]
    segControl.frame = CGRectMake(0, 0, 150, 30)
    segControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
    segControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
    segControl.verticalDividerEnabled = true
    segControl.verticalDividerColor = UIColor.blackColor()
    navigationController?.navigationItem.titleView = segControl
    refresh = UIRefreshControl()
    refresh.addTarget(self, action: Selector("refreshData"), forControlEvents: .ValueChanged)
    refresh.attributedTitle = NSAttributedString(string: "拉我刷新")
    topicTableView.addSubview(refresh)
    
        //register Topic cell
    let cellNib = UINib(nibName: "TopicCell", bundle: nil)
    topicTableView.registerNib(cellNib, forCellReuseIdentifier: "TopicCell")
    topicTableView.registerNib(cellNib, forHeaderFooterViewReuseIdentifier: "111")

    fetchData()
    topicTableView.tableFooterView = UIView()
    topicTableView.separatorColor = UIColor.clearColor()
    topicTableView.rowHeight = UITableViewAutomaticDimension
    topicTableView.estimatedRowHeight = 88.0
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func refreshData() {
    fetchData()
  }
  
  func fetchData() {
    APIClient.sharedInstance.getLatestTopics({ (json) -> Void in
      
    
      if json.type == Type.Array {
        self.dataSource = json.arrayValue
        
        
     
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.topicTableView.reloadData()
          self.refresh.endRefreshing()
        })

        
      }
      
      }, failure: {(err) -> Void in
        
    })
    
    
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let data = dataSource {
      return data.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowContent", sender: indexPath)
    topicTableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = topicTableView.dequeueReusableCellWithIdentifier("TopicCell") as! TopicCell
    
    let dataJson = dataSource[indexPath.row]
    

    cell.nodeName.text = dataJson["node"]["title"].stringValue

    
    cell.autherName.text = dataJson["member"]["username"].stringValue
    cell.replyNum.text = dataJson["replies"].stringValue
    cell.topicTitle.text = dataJson["title"].stringValue
    
    let url = "http:" + dataJson["member"]["avatar_large"].stringValue
    cell.avatarView.kf_setImageWithURL(NSURL(string: url)!)




    return cell
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let cell = topicTableView.dequeueReusableCellWithIdentifier("TopicCell") as! TopicCell
    return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowContent" {
      let NavVc = segue.destinationViewController as! UINavigationController
      let vc = NavVc.childViewControllers[0] as! TopicContentViewController
      let indexpath = sender as! NSIndexPath
      vc.data = dataSource[indexpath.row]
    }
  }


}

