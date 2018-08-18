//
//  FeedCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/19/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var messageLb: UILabel!
    @IBOutlet weak var userEmailLb: UILabel!
    @IBOutlet weak var profileIv: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateRow(message : Message)  {
        messageLb.text = message.message
        userEmailLb.text = message.senderId
        let date = Utils.instance.convertTimestamp(serverTimestamp: message.timeStamp)
        print("date \(date ) date obj \(Date(timeIntervalSince1970: message.timeStamp))")
        timeStamp.text = Date(timeIntervalSince1970: message.timeStamp / 1000).timeAgoDisplay()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }

}
