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

    var messages = [Message]()
    
    @IBOutlet weak var profileFeedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    private func setUpView(){
        profileFeedTableView.delegate = self
        profileFeedTableView.dataSource = self
        profileFeedTableView.rowHeight = UITableViewAutomaticDimension
        profileFeedTableView.estimatedRowHeight = 150
     
    }
    
 

    //1C1C24

    @IBAction func logoutBtnPressed(_ sender: Any) {
        logout()
    }
    private func logout(){
        do {
            try   Auth.auth().signOut()
            let authVc = storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
            self.presentVC(viewController: authVc)
        }catch{
            debugPrint("logout error \(String(describing : error.localizedDescription ))")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllMessageForUid(forId: (Auth.auth().currentUser?.uid)!) { (messages) in
            self.messages = messages
            self.profileFeedTableView.reloadData()
        }
    }
    

}

extension ProfileVC : UITableViewDelegate , UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  messages.count > 0{
            return messages.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.row) {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as? ProfileHeaderCell{
                
                return cell
            }
        default:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFeedCell", for: indexPath) as? FeedCell{
                if let name = Auth.auth().currentUser?.displayName{
                    cell.updateRow(message: messages[indexPath.row] , email: (Auth.auth().currentUser?.displayName)!)
                }else{
                    cell.updateRow(message: messages[indexPath.row] , email: (Auth.auth().currentUser?.email)!)
                }

                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
