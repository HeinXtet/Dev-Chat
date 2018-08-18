//
//  AuthService.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {
    static let instance = AuthService()
    
    
    func registerUser(email:String ,password:String , createUserCompletionHander : @escaping (_ isSuccess : Bool ,_ error : Error?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                createUserCompletionHander(false,error)
                debugPrint("register user error \(String(describing: error?.localizedDescription))")
                return
            }
            let userData = user.user
            let data = ["provider" : userData.providerID , "email" : userData.email] as Dictionary
            print("register success \(data) \(user.user.uid)")
            DataService.instance.createUserDB(uId: userData.uid, userData:  data )
            createUserCompletionHander(true,nil)
        }
    }
    
    func loginUser(email:String ,password:String , loginUserCompletionHander : @escaping (_ isSuccess : Bool ,_ error : Error?)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let _ = result else {
                loginUserCompletionHander(false,error)
                debugPrint("login user error \(String( describing :error?.localizedDescription))")
                return
            }
            loginUserCompletionHander(true,nil)
        }
    }
    
}

