//
//  GroupCell.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/26/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var memberCountLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateGroup(group : GroupModel){
        titleLb.text = group.groupName
        descriptionLb.text = group.groupDescription
        memberCountLb.text = " \(group.members.count) members" 
    }
}
