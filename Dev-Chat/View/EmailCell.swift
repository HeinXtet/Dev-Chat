//
//  EmailCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/20/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class EmailCell: UITableViewCell {
    @IBOutlet weak var EmailLb: UILabel!
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var markIv: UIImageView!
    var tempUserModel : UserModel? = nil
    var choose  : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       if (isSelected)
    {
        if choose{
            markIv.isHidden = true
            choose = false
        }else{
            choose = true
            markIv.isHidden = false
        }
    }
    }
    
    func updateCell(imagePath : String , userModel :UserModel , isSelected : Bool){
        tempUserModel = userModel
        self.EmailLb.text = userModel.email
        self.iv.image = UIImage(named: imagePath)
        self.choose = isSelected
        if (isSelected){
            markIv.isHidden = false
        }else{
             markIv.isHidden = true
        }
    }

}
