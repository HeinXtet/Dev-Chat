//
//  OtherSenderCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 9/2/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class OtherSenderCell: UITableViewCell {
    
    @IBOutlet weak var nameLb : UILabel!
    @IBOutlet weak var messageLb : UILabel!
    @IBOutlet weak var dateLb : UILabel!
    @IBOutlet weak var  messageFrame  : UIView!
    
    @IBOutlet weak var messageFrameWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    
    func updateCell(messageModel : Message) {
        self.messageLb.text = messageModel.message
        let date = Utils.instance.convertTimestamp(serverTimestamp: messageModel.timeStamp)
        self.dateLb.text = Date(timeIntervalSince1970: messageModel.timeStamp / 1000).timeAgoDisplay()
    }
    
    
    private func setUpView(){
        self.selectionStyle = .none
        messageFrameWidth.constant = self.frame.width /  1.5
        messageFrame.backgroundColor = #colorLiteral(red: 1, green: 0.5215144157, blue: 0, alpha: 1)
        messageFrame.layer.cornerRadius =  15
        messageLb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        messageLb.numberOfLines = 0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
