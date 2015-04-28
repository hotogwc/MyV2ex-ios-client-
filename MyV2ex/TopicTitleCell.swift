//
//  TopicTitleCell.swift
//  MyV2ex
//
//  Created by wangchi on 15/4/28.
//  Copyright (c) 2015年 wangchi. All rights reserved.
//

import UIKit

class TopicTitleCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var avatarView: UIImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var replyNumLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
