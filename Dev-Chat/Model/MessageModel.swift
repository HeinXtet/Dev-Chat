//
//  MessageModel.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/19/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation

class Message {
    var message  : String
    var senderId : String
    var timeStamp : Double
    
    init(message : String , senderId : String, timeStamp : Double) {
        self.message = message
        self.senderId = senderId
        self.timeStamp = timeStamp
    }
    
}
