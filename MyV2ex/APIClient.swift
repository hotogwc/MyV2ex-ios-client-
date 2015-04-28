//
//  APIClient.swift
//  v2ex
//
//  Created by liaojinxing on 14-10-16.
//  Copyright (c) 2014年 jinxing. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let APIRootURL = "http://www.v2ex.com/api/"

class APIClient {
   
    class var sharedInstance : APIClient {
        struct Static {
            static let instance : APIClient = APIClient()
        }
        return Static.instance
    }
    
    func getJSONData(path: NSString, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {

        Alamofire.request(.GET, APIRootURL + (path as String), parameters: parameters).response { (request, response, data, error) -> Void in
          println("\(APIRootURL)\(path)")
          if let err = error {
            println("\(err)")
            failure(err)
          } else {
            let json = JSON(data: data! as! NSData , options: .AllowFragments, error: nil)
            success(json)
  
          }
        }
  }
    func getLatestTopics(success: (JSON) -> Void, failure: (NSError) -> Void) {
    
        self.getJSONData("topics/hot.json", parameters: nil, success: success, failure: failure)
    }
    
    func getTopicsForNode(nodeID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["node_id": nodeID]
        self.getJSONData("topics/show.json", parameters: dict, success: success, failure: failure)
    }
    
    func getRepliesForTopic(topicID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["topic_id": topicID]
        self.getJSONData("replies/show.json", parameters: dict, success: success, failure: failure)
    }
    
    func getNodes(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData("nodes/all.json", parameters: nil, success: success, failure: failure)
    }

}
