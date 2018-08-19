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
        setUpView()
    }
    
    private func setUpView(){
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.4787634835, green: 0.4787634835, blue: 0.4787634835, alpha: 0.75)
        self.selectedBackgroundView = bgColorView
        
        self.layer.shadowRadius = 0.80
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    func updateRow(message : Message, email :String)  {
        messageLb.text = message.message
        userEmailLb.text = email
        let date = Utils.instance.convertTimestamp(serverTimestamp: message.timeStamp)
        print("date \(date ) date obj \(Date(timeIntervalSince1970: message.timeStamp))")
        timeStamp.text = Date(timeIntervalSince1970: message.timeStamp / 1000).timeAgoDisplay()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }

}
