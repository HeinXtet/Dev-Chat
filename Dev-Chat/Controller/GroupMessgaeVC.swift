

//  GroupMessgaeVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/26/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseAuth


class GroupMessgaeVC: UIViewController {
    @IBOutlet weak var uitextView : UITextView!
    var estimateHight : CGSize? = nil
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textHight: NSLayoutConstraint!
    @IBOutlet weak var memberLb: UILabel!
    private var groupInfo : GroupModel?
    @IBOutlet weak var uiTableView : UITableView!
    @IBOutlet weak var groupTitleLb  : UILabel!
    private var messages  = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uitextView.delegate = self
        uitextView.isScrollEnabled = false
        uiTableView.dataSource = self
        uiTableView.delegate = self
        groupTitleLb.text = groupInfo?.groupName
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setUpComponent()
        
    }
    
    private func setUpComponent(){
        var member = ""
        DataService.instance.getEmail(group: groupInfo!) { (emailArray) in
            self.memberLb.text = "you , \(member) "
            let filterEmail = emailArray.filter{$0 != userEmail}
            member = filterEmail.joined(separator: " ,")
        self.memberLb.text = "you , \(member)"}
        
        DataService.instance.getAllGroupMessages(groupId: groupInfo!.groupId) { (messages) in
            debugPrint("groupMessage \(messages.count)")
            if  self.messages.count > 0{
                self.messages.removeAll()
            }
            self.messages = messages
            self.uiTableView.reloadData()
        }
    }
    
    func setGroupInfo(groupInfo : GroupModel){
        self.groupInfo = groupInfo
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
    @IBAction func backPressBtnPressed(_ sender: Any) {
        self.dissmissVC()
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard let msg = uitextView.text else {
            return
        }
        DataService.instance.createPost(message: msg, uId: Auth.auth().currentUser!.uid, groupKey: groupInfo?.groupId) { (isSuccess, isError ) in
            if isSuccess{
                debugPrint("message success")
                self.uitextView.endEditing(true)
            }
            
        }
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


extension GroupMessgaeVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.messages[indexPath.row].senderId == Auth.auth().currentUser!.uid{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelfSenderCell", for: indexPath) as! SelfSenderCell
            cell.updateCell(messageModel: messages[indexPath.row])
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherSenderCell", for: indexPath) as! OtherSenderCell
            cell.updateCell(messageModel: messages[indexPath.row])
            return cell
        }
        
    }
    
}















