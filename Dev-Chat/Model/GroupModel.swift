//
//  File.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/26/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
class GroupModel{
    
    var groupName : String
    var groupDescription : String
    var members : [String]
    var groupId : String
    
    init(groupId : String, groupName : String, description : String , member : [String]) {
        self.groupId = groupId
        self.groupName = groupName
        self.groupDescription = description
        self.members = member
    }
}
