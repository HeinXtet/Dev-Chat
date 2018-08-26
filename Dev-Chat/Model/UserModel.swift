//
//  UserModel.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/26/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
class UserModel {
    
    var id : String
    var email : String
    init(id : String, email :String) {
     self.email = email
     self.id = id
    }
}
