//
//  SelfSenderCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 9/2/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class SelfSenderCell: UITableViewCell {

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
        self.dateLb.text = Date(timeIntervalSince1970: messageModel.timeStamp / 1000).timeAgoDisplay()
    }
    
    
    private func setUpView(){
        self.selectionStyle = .none
        messageFrameWidth.constant = self.frame.width /  1.5
        messageFrame.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        messageFrame.layer.cornerRadius =  15
        messageLb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        messageLb.numberOfLines = 0
        self.messageFrame.layer.shadowOpacity = 4
        self.messageFrame.layer.shadowColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
