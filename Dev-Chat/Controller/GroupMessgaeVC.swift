

//  GroupMessgaeVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/26/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class GroupMessgaeVC: UIViewController {

    @IBOutlet weak var uitextView : UITextView!
    var estimateHight : CGSize? = nil
    var textView : UITextView?
    
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textHight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpTextField()
        
        uitextView.isScrollEnabled = false
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

//    private func setUpTextField(){
//        textView = UITextView()
//        view.addSubview(textView!)
//        textView!.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
//        textView!.bindToKeyboard()
//        textView!.translatesAutoresizingMaskIntoConstraints = false
//        [
//            textView!.bottomAnchor.constraint(equalTo:
//            view.safeAreaLayoutGuide.bottomAnchor),
//            textView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            textView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            textView!.heightAnchor.constraint(equalToConstant: 40)
//            ].forEach{
//                $0.isActive = true
//             }
//        textView!.font =     UIFont.preferredFont(forTextStyle: .headline)
//        textView!.delegate = self
//        textView!.isScrollEnabled = false
//    }
}

extension GroupMessgaeVC : UITextViewDelegate{
    

    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: uitextView.frame.width, height: .infinity)
        let estimateSize = textView.sizeThatFits(size)
        estimateHight = estimateSize
        textView.heightAnchor.constraint(equalToConstant: estimateSize.height + 20)
//        textHight.constant = estimateHight!.height
        bottomViewHeight.constant = estimateSize.height + 20

    }
    
    
    private func brainIdea(){
        
    }
    
}















