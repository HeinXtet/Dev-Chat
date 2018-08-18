//
//  UIViewExt.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChanged(_ notification : Notification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let startFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let delta = endFrame.origin.y - startFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += delta
        }, completion: nil)
        
    }
    
}

