//
//  AppConstants.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/19/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation

let dissmissHandler  =  NSNotification.Name(rawValue: "modalIsDimissed")
let noti_mess  =  NSNotification.Name(rawValue: "backgroundMessage")
var  userEmail = ""
let OTHER = 0
let SELF = 1

var message = [
    MessageModel(type : OTHER ,message : "This is test messaging" , date : 123232323, name :"User name"),
    MessageModel(type : SELF ,message : "This is test messagingnn,This is test messagingThis is test messaging" , date : 123232323, name :"Hein Htet"),
    MessageModel(type : OTHER ,message : "This is test messaging. This is test messaging" , date : 123232323, name :"User name"),
    MessageModel(type : SELF ,message : "This is test messaging, This is test messaging ,This is test messaging" , date : 123232323, name :"Hein Htet")
]

class MessageModel {
    var type : Int
    var message : String
    var date : CLong
    var name :String
    init(type : Int,message : String , date : CLong, name :String) {
        self.date = date
        self.name = name
        self.message = message
        self.type = type
    }
    
}






