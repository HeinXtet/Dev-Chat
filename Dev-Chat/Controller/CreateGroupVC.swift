//
//  CreateGroupVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/20/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateGroupVC: UIViewController {
    
    @IBOutlet weak var choosePersonLb: UILabel!
    @IBOutlet weak var personTableView: UITableView!
    @IBOutlet weak var emailField: InserTxField!
    @IBOutlet weak var descriptionField: InserTxField!
    @IBOutlet weak var nameField: InserTxField!
    private var emails = [UserModel]()
    private var allEmail = [UserModel]()
    private var chooseEmails = [String]()
    private var userId = [String]()
    private var chooseUserList = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        DataService.instance.findEmails(all: true, findEmailQuery: "") { (email) in
            self.allEmail = email
            self.emails = email
            self.personTableView.reloadData()
        }
    }
    
    private func setUpView(){
        personTableView.dataSource = self
        personTableView.delegate = self
        emailField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc func textChanged(){
        if emailField.text != "" {
            DataService.instance.findEmails(all : false,findEmailQuery: emailField.text!) { (emailArray) in
                self.emails = emailArray
                self.personTableView.reloadData()
            }
        }else{
            emails.removeAll()
            emails = allEmail
            self.personTableView.reloadData()
        }
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        guard let title = nameField.text else {return}
        guard let description  = descriptionField.text else {return}
        
        if chooseUserList.count < 0{
            return
        }
        
        for user in chooseUserList{
            userId.append(user.id)
        }
        
        userId.append(Auth.auth().currentUser!.uid)
        DataService.instance.createGroup(title: title, description: description, id: userId , createdUserId:  Auth.auth().currentUser!.uid) { (success) in
            if (success){
                debugPrint("success created group")
                self.userId.removeAll()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

extension CreateGroupVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EmailCell else {
            return
        }
        if !chooseEmails.contains(cell.EmailLb.text!){
            chooseEmails.append(cell.EmailLb.text!)
            choosePersonLb.text = chooseEmails.joined(separator: ",")
            chooseUserList.append(cell.tempUserModel!)
            debugPrint("chooseUser List \(chooseUserList.count)")
        }else{
            chooseEmails = chooseEmails.filter({$0 !=  cell.EmailLb.text!})
            removeChooseUser(email: cell.EmailLb.text!)
            debugPrint("chooseUser List \(chooseUserList.count)")
            if chooseEmails.count > 0 {
                choosePersonLb.text = chooseEmails.joined(separator: ",")

            }else{
                choosePersonLb.text = "Add People To Group"
            }
        }
        
        print("select row \(cell.EmailLb.text!)")
    }

    private func removeChooseUser(email:String){
        var tempList = [UserModel]()
        for choosed in chooseUserList{
            if choosed.email != email{
                tempList.append(choosed)
            }
        }
        chooseUserList.removeAll()
        chooseUserList = tempList
        userId.removeAll()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EmailCell", for: indexPath) as? EmailCell{
            
            if chooseEmails.contains(emails[indexPath.row].email){
                cell.updateCell(imagePath: "defaultProfileImage", userModel: emails[indexPath.row],isSelected : true)
            }else{
                cell.updateCell(imagePath: "defaultProfileImage", userModel : emails[indexPath.row],isSelected : false)

            }
            
            return cell
        }
        return UITableViewCell()
    }
}
