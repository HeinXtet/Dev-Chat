//
//  ViewController.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/17/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

