//
//  ViewController.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/17/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FirebaseAuth
import ProgressHUD


class AuthVC: UIViewController {

    @IBOutlet weak var ggBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.dismiss()
        fbBtn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(accessToken.authenticationToken)" )
                AuthService.instance.loginFb(token: accessToken.authenticationToken, completionHandler: { (isSuccess) in
                    if isSuccess{
                        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UITabBarController
                        self.presentVC(viewController: homeVc)
                    }
                    
                })
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gLoginPressed(_ sender: Any) {
    }
    @IBAction func fbLoginPressed(_ sender: Any) {
    }
    @IBAction func loginEmailPressed(_ sender: Any) {
        
        let emailVc = storyboard?.instantiateViewController(withIdentifier: "EmailLoginVC") as! EmailLoginVC
        self.presentVC(viewController: emailVc)
    }
    
}

