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
import FirebaseAuth

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

let DB_BASE = Database.database().reference()


class DataService {
    static let instance = DataService()
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
    
    
    func getAllGroupMessages(groupId : String , handler : @escaping (_ message : [Message])->Void){
        var messagesArray = [Message]()
       
        REF_GROUP.child(groupId).child("messages").observe(.value) { (snap) in
            guard let messages = snap.children.allObjects as? [DataSnapshot] else {return}
            
            if messagesArray.count > 0{
                messagesArray.removeAll()
            }
            
            for message in messages{
                messagesArray.append(Message(message:
                    message.childSnapshot(forPath: "message").value as! String
                    , senderId: message.childSnapshot(forPath: "senderId").value as! String,
                      timeStamp: message.childSnapshot(forPath: "time_stamp").value as! Double))
            }
            handler(messagesArray)
        }
    
    }
    
    
    func createPost(message : String , uId : String,  groupKey : String? , createPostCompletion : @escaping (_ isSuccess : Bool ,_ error : Error? )->Void ) {
        let time = ServerValue.timestamp()
        if (groupKey != nil){
            let message =  ["message" : message , "senderId" : uId, "time_stamp" : time] as [String : Any]
            REF_GROUP.child(groupKey!).child("messages").childByAutoId().updateChildValues(message)
        }else{
            REF_FEED.childByAutoId().updateChildValues(["content" : message , "senderId" : uId, "time_stamp" : time])
        }
        createPostCompletion(true,nil)
    }
    
    func getAllMessage(groupkey : String? , completionHandler : @escaping (_ isSuccess  : Bool , _ message :  [Message])->Void){
        var messages = [Message]()
        
        
        REF_FEED.observe(.value, with: { (feedSnapShot) in
            
            do{
                guard let feedMessage = feedSnapShot.children.allObjects as? [DataSnapshot] else {return}
                print("observe messaging \(feedMessage.count)")
                // important twice call for firebase
                if messages.count > 0 {
                    messages.removeAll()
                }
                for message in feedMessage{
                    messages.append(Message(message: message.childSnapshot(forPath: "content").value as! String,
                                            senderId: message.childSnapshot(forPath: "senderId").value as! String,
                                            timeStamp : message.childSnapshot(forPath: "time_stamp").value as! Double))
                }
                completionHandler(true,messages)
                NotificationCenter.default.post(name: noti_mess, object: nil)
            } catch{
                completionHandler(false,messages)
                debugPrint("message fetch error catch Block \(String(describing: error.localizedDescription))")
            }
        }) { (error) in
            completionHandler(false,messages)
            debugPrint("message fetch error \(String(describing: error.localizedDescription))")
        }
        
    }
    
    func getEmailForUiD(forId uId: String, completion : @escaping (_ email : String)-> Void) {
        REF_USER.observe(.value) { (userSnapShot) in
            guard let snap = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in snap{
                debugPrint("user key \(user.key) check key \(uId)")
                if user.key == uId{
                    debugPrint(String(describing: user.childSnapshot(forPath: "email")))
                    completion(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getEmail(group :GroupModel, handler : @escaping (_ email : [String])->Void){
        REF_USER.observeSingleEvent(of: .value) { (user) in
            var userEmail = [String]()
            userEmail.removeAll()
            guard let userDataSnapShot = user.children.allObjects as? [DataSnapshot] else {return}
            for userData in userDataSnapShot{
                if group.members.contains(obj: userData.key){
                      userEmail.append(userData.childSnapshot(forPath: "email").value as! String)
                }
            }
            handler(userEmail)
        }
    }
    
    
    func getAllMessageForUid(forId uId : String ,  completion : @escaping (_ message : [Message])->Void)  {
        REF_FEED.observe(.value) { (snapShot) in
            var messages = [Message]()
            guard let feedSnap =  snapShot.children.allObjects as? [DataSnapshot] else {return}
            if messages.count > 0{
                messages.removeAll()
            }
            for feed in feedSnap{
                if feed.childSnapshot(forPath: "senderId").value as! String == uId{
                    print("child is equal \(feed)")
                    messages.append(Message(message: feed.childSnapshot(forPath: "content").value as! String,
                                            senderId: feed.childSnapshot(forPath: "senderId").value as! String,
                                            timeStamp: feed.childSnapshot(forPath: "time_stamp").value as! Double))
                    
                }
                
            }
            completion(messages)
            
        }
    }
    

    func findEmails(all :Bool ,findEmailQuery email : String , completionHandler : @escaping (_ emailLists : [UserModel])->Void) {
        var emailArray = [UserModel]()
        REF_USER.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnap = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            if emailArray.count > 0{
                emailArray.removeAll()
            }
            if all {
                for user in userSnap{
                    let email = user.childSnapshot(forPath: "email").value as! String
                    if email != userEmail{
                        emailArray.append(UserModel(id : user.key , email : user.childSnapshot(forPath: "email").value as! String))
                    }
                }
                completionHandler(emailArray)
            }else{
                for user in userSnap{
                    let userE = user.childSnapshot(forPath: "email").value as! String
                    if userE.lowercased().contains(email.lowercased()) {
                        if userE != userEmail{                        
                            emailArray.append(UserModel(id : user.key , email : user.childSnapshot(forPath: "email").value as! String))
                        }
                    }
                }
                completionHandler(emailArray)
            }
            
        }
    }
    
    
    func createGroup(title:String,description:String, id : [String], createdUserId : String ,  completionHandler : @escaping (_ isSuccess : Bool)->Void)  {
        let gruopHash = ["title" : title , "description" : description , "user_id" : id , "createdUser" : createdUserId] as [String : Any]
        REF_GROUP.childByAutoId().updateChildValues(gruopHash)
        completionHandler(true)
    }
    
    func getAllGroup(completionHandler : @escaping (_ group : [GroupModel])->Void) {
        var groupArray = [GroupModel]()
        REF_GROUP.observe(.value) { (groupSnapShot) in
            groupArray.removeAll()
            guard let groupSanp = groupSnapShot.children.allObjects as? [DataSnapshot] else {return }
            for group in groupSanp {
                let userIdArray = group.childSnapshot(forPath: "user_id").value as! [String]
                for id in userIdArray{
                    if id == Auth.auth().currentUser!.uid{
                        groupArray.append(GroupModel(groupId : group.key,groupName: group.childSnapshot(forPath: "title").value as! String, description:group.childSnapshot(forPath: "description").value as! String, member: userIdArray))
                    }
                }
            }
            completionHandler(groupArray)
            
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


