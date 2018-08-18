//
//  ProfileVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var userEmailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user =  Auth.auth().currentUser {
            userEmailLabel.text = user.email
            debugPrint(String(describing: user.displayName))
            DataService.instance.getTest(id: user.uid)
        }      
    }
    //1C1C24

    @IBAction func logoutBtnPressed(_ sender: Any) {
        logout()
    }
    private func logout(){
        do {
            try   Auth.auth().signOut()
            var authVc = storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
            self.presentVC(viewController: authVc)
        }catch{
            debugPrint("logout error \(String(describing : error.localizedDescription ))")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
