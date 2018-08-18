//
//  DataService.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    let _REF_BASE  = DB_BASE
    
    private let _REF_USERS = DB_BASE.child("users")
    private let _REF_GROUPS = DB_BASE.child("groups")
    private let _REF_FEEDS = DB_BASE.child("feeds")
    
    var REF_USER : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUP : DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference {
        return _REF_FEEDS
    }

    func createUserDB (uId : String, userData : Dictionary<String,Any>){
     REF_USER.child(uId).updateChildValues(userData)
    }
    
    func createPost(message : String , uId : String,  groupKey : String? , createPostCompletion : @escaping (_ isSuccess : Bool ,_ error : Error? )->Void ) {
        let time = ServerValue.timestamp()
        if (groupKey != nil){
            
        }else{
            REF_FEED.childByAutoId().updateChildValues(["content" : message , "senderId" : uId, "time_stamp" : time])
        }
        createPostCompletion(true,nil)
    }
    
    func getAllMessage(groupkey : String? , completionHandler : @escaping (_ isSuccess  : Bool , _ message :  [Message])->Void){
        var messages = [Message]()
        REF_FEED.observeSingleEvent(of: .value, with: { (feedSnapShot) in
            guard let feedMessage = feedSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for message in feedMessage{
                messages.append(Message(message: message.childSnapshot(forPath: "content").value as! String,
                                        senderId: message.childSnapshot(forPath: "senderId").value as! String,
                                        timeStamp : message.childSnapshot(forPath: "time_stamp").value as! Double))
            }
            completionHandler(true,messages)
        }) { (error) in
            completionHandler(false,messages)
            debugPrint("message fetch error \(String(describing: error.localizedDescription))")
        }
    }
    
    func getTest(id: String){
        REF_USER.child(id).observeSingleEvent(of: .value) { (snapShot) in
            debugPrint("user snapshot \(String(describing: snapShot.childrenCount))")
            if let result = snapShot.children.allObjects as? [DataSnapshot] {
                debugPrint("user snapshot \(String(describing: result))")
                for child in result {
                    let user = child.key
                    print(user)
                }
            }
        }
    }
    
}


