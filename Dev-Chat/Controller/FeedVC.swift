//
//  FeedVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import ProgressHUD
import UserNotifications

class FeedVC: UIViewController,UNUserNotificationCenterDelegate {
    
    var messages = [Message]()
    var emails = [String]()

    @IBOutlet weak var feedTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
       // getAllMessage()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })
        
        showNoti()
        
        
       
    }
    

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()     }
    
    private func showNoti(){
        //creating the notification content
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Hey this is Simplified iOS"
        
        content.subtitle = "iOS Development is fun"
        content.body = "We are learning about iOS Local Notification"
        content.badge = 1
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    private func setUpView(){
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.rowHeight = UITableViewAutomaticDimension
        feedTableView.estimatedRowHeight = 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint(" observe view did appear")
        getAllMessage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("did appear")
    }
    
func getAllMessage(){
       // ProgressHUD.show("Please wait... ", interaction: false)
        DataService.instance.getAllMessage(groupkey: nil) { (success, messages) in
            if (success){
                self.messages.removeAll()
                self.emails.removeAll()
                self.messages = messages.reversed()
                print("Feeed message success Count \(messages.count)")
                if !messages.isEmpty{
                    messages.reversed().forEach({ (message) in
                        DataService.instance.getEmailForUiD(forId: message.senderId) { (email) in
                            self.emails.append(email)
                            if (self.emails.count == self.messages.count){
                                ProgressHUD.dismiss()
                                print("reload table view")
                                DispatchQueue.main.async{
                                    self.reload()
                                }
                            }
                        }
                    })
                }else{
                    ProgressHUD.dismiss()
                }
               
            }
        }
    }

    @IBAction func createPostBtnPressed(_ sender: Any) {
        let postVc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        postVc.modalPresentationStyle = .custom
        present(postVc, animated: true, completion: nil)
    }
    
    private func reload(){
        UIView.transition(with: feedTableView, duration: 1.0, options: .transitionCrossDissolve, animations: {self.feedTableView.reloadData()}, completion: nil)
        feedTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
}



extension FeedVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell{
            let message = messages[indexPath.row]
            cell.updateRow(message: message, email: emails[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 150
        return UITableViewAutomaticDimension
    }
}
