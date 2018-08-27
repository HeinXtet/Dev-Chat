

//  GroupMessgaeVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/26/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import ProgressHUD

class GroupMessgaeVC: UIViewController {
    @IBOutlet weak var uitextView : UITextView!
    var estimateHight : CGSize? = nil
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textHight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        uitextView.delegate = self
        uitextView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if uitextView!.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        uitextView.endEditing(true)
//        uitextView.text = "Enter Message"
//        uitextView.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
}

extension GroupMessgaeVC : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: uitextView.frame.width, height: .infinity)
        let estimateSize = textView.sizeThatFits(size)
        estimateHight = estimateSize
        bottomViewHeight.constant = estimateSize.height + 20
        print("textViewDidChange")
    }
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
        if textView.text == ""{
            textView.text = "Enter Message"
        }
    }
}















