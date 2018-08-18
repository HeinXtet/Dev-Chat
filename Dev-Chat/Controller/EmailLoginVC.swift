//
//  EmailLoginVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import ProgressHUD

class EmailLoginVC: UIViewController {
    

    @IBOutlet weak var passEdField: InserTxField!
    @IBOutlet weak var emailEdField: InserTxField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signIn(_ sender: Any) {
        ProgressHUD.show("Please wait..",interaction : false)
        print("user email\(self.emailEdField.text!)")
        AuthService.instance.loginUser(email: emailEdField.text!, password: passEdField.text!) { (iSuccess, error) in
            if iSuccess{
                debugPrint("success login \(self.emailEdField.text!)")
                self.goToHomeVc()
            }else{
                self.dissmissProgressHUD()
                debugPrint("\(String(describing : error?.localizedDescription) )")
            }
            AuthService.instance.registerUser(email: self.emailEdField.text!, password: self.passEdField.text!) { (iSuccess, error) in
                if iSuccess{
                    debugPrint("success register user\(self.emailEdField.text!)")
                    self.goToHomeVc()
                }else{
                    self.dissmissProgressHUD()
                    debugPrint("\(String(describing : error?.localizedDescription) )")
                }
        }
    }
    }
    
    private func dissmissProgressHUD(){
        ProgressHUD.dismiss()
    }
    
    private func goToHomeVc(){
        dissmissProgressHUD()
        let homeVc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UITabBarController
        self.presentVC(viewController: homeVc)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dissmissVC()
    }
}
