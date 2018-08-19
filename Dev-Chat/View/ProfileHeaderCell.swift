//
//  ProfileHeaderCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/19/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import FirebaseAuth
class ProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var emailLb : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        if let email = Auth.auth().currentUser?.email{
             emailLb.text = email
        }else{
            emailLb.text = Auth.auth().currentUser?.displayName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
