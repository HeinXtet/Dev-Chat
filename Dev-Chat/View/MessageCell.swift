//
//  MessageCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 9/2/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var bgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var messageLb: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //testView()
       
        self.selectionStyle = .none
    }
    
    
    func testView(){
        let testView = UIView()
        testView.frame = CGRect(x: (self.frame.width / 2 ) - testView.frame.width, y: 0, width: self.frame.width / 2, height: self.frame.height)
        testView.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        addSubview(testView)
        
    }
    
    func isYour(your : Bool , messageTv : String){
        bgView.layer.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        bgView.layer.cornerRadius = 8
        messageLb.numberOfLines = 0
        messageLb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bgViewWidth.constant = self.frame.width / 1.5
        self.messageLb.text = messageTv
    }
    
    
    
    private func setUpViewForSelf(){
        
    }
    
    
    private func setUpViewForSender(){
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
