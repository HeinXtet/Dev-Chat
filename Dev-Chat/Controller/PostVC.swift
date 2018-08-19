//
//  PostVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD

class PostVC: UIViewController {

    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userIv: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    @IBAction func clsoeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func postBtnPressed(_ sender: Any) {
        ProgressHUD.show("Please wait...", interaction: false)
        guard postText.text != nil ,  postText.text != "Write something..." else {
            return
        }
        DataService.instance.createPost(message: postText.text!, uId: (Auth.auth().currentUser?.uid)!, groupKey: nil) { (success, error) in
            if success {
                self.hideProgress()
                self.dissmsis()
                debugPrint(String(describing: "sussessful create post"))
            }else{
                self.dissmsis()
                debugPrint("error create post\(String(describing:error?.localizedDescription))")
                self.hideProgress()
            }
        }
    }
    
    private func hideProgress(){
        ProgressHUD.dismiss()
    }
    
    private func setUpView(){
        postBtn.bindToKeyboard()
        postText.delegate = self
        if let email = Auth.auth().currentUser?.email{
             userEmail.text = email
        }else{
            userEmail.text = Auth.auth().currentUser?.displayName
        }
       
    }
    
    
    private func dissmsis(){
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: dissmissHandler, object: nil)
        }
    }
    
}

extension PostVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
