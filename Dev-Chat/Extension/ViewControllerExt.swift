//
//  ViewControllerExt.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    
    func presentVC(viewController : UIViewController)  {
        let transaction = CATransition()
        transaction.duration = 0.4
        transaction.type = kCATransitionPush
        transaction.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transaction, forKey: kCATransition)
        present(viewController, animated: false, completion: nil)
    }
    
    func presentToViewController(vc : UIViewController) {
        let transaction = CATransition()
        transaction.duration = 0.3
        transaction.type = kCATransitionPush
        transaction.subtype = kCATransitionFromRight
        guard let presentedViewController = presentedViewController else {return}
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transaction, forKey: kCATransition)
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    
    
    func dissmissVC() {
        let transaction = CATransition()
        transaction.duration = 0.4
        transaction.type = kCATransitionPush
        transaction.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transaction, forKey: kCATransition)
        dismiss(animated: false, completion: nil)    }
    
}
