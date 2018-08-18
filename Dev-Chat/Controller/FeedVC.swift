//
//  FeedVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import ProgressHUD
class FeedVC: UIViewController {
    
    var messages = [Message]()

    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView(){
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.rowHeight = UITableViewAutomaticDimension
        feedTableView.estimatedRowHeight = 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(getAllMessage), name: dissmissHandler, object: nil)
        getAllMessage()
    }
    
    @objc  func getAllMessage(){
        ProgressHUD.show("Please wait... ", interaction: false)
        DataService.instance.getAllMessage(groupkey: nil) { (success, messages) in
            ProgressHUD.dismiss()
            if (success){
                self.messages.removeAll()
                self.messages = messages
                print("Feed Count \(messages.count)")
                DispatchQueue.main.async {
                    self.feedTableView.reloadData()
                }
            }
            
        }
    }

    @IBAction func createPostBtnPressed(_ sender: Any) {
        
        let postVc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        postVc.modalPresentationStyle = .custom
        present(postVc, animated: true, completion: nil)
    }
    

}

extension FeedVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell{
            cell.updateRow(message : messages[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
}
