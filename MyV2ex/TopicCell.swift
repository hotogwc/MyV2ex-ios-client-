//
//  TopicCell.swift
//  MyV2ex
//
//  Created by wangchi on 15/4/13.
//  Copyright (c) 2015年 wangchi. All rights reserved.
//

import UIKit
import QuartzCore

class TopicCell: UITableViewCell {
  @IBOutlet weak var avatarView: UIImageView!
  @IBOutlet weak var topicTitle: UILabel!
  @IBOutlet weak var nodeName: UILabel!
  @IBOutlet weak var autherName: UILabel!
  @IBOutlet weak var replyNum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    avatarView.setTranslatesAutoresizingMaskIntoConstraints(false)
    topicTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
    nodeName.setTranslatesAutoresizingMaskIntoConstraints(false)
    autherName.setTranslatesAutoresizingMaskIntoConstraints(false)
    replyNum.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    
  }
  

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
