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
            let data = ["provider" : userData.providerID , "email" : userData.email , "name" : userData.displayName] as Dictionary
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
    
    func loginFb(token : String , completionHandler : @escaping (_ success : Bool)->Void){
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                debugPrint("facebook login error \(String(describing: error.localizedDescription))")
                completionHandler(false)
                return
            }
            if let user = authResult?.user{
                var email = user.email
                if user.email == nil{
                    email = user.displayName
                }
                let data = ["provider" : user.providerID , "email" : email , "name" : user.displayName] as Dictionary
                DataService.instance.createUserDB(uId: user.uid, userData: data)
                completionHandler(true)
            }
        }
    }

    
}

