//
//  GroupVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/20/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import FirebaseAuth

class GroupVC: UIViewController {

    @IBOutlet weak var gpTableView: UITableView!
    private var groupArray = [GroupModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }
    
    private func setUpView(){
        gpTableView.dataSource = self
        gpTableView.delegate = self
    }
    
    @IBAction func createGpBtnPressed(_ sender: Any) {
        let createGpVc = storyboard?.instantiateViewController(withIdentifier: "CreateGroupVC") as! CreateGroupVC
        createGpVc.modalPresentationStyle = .custom
        present(createGpVc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllGroup { (groups) in
            self.groupArray = groups
            self.gpTableView.reloadData()
        }
    }
    
    
}

extension GroupVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell {
            cell.updateGroup(group: groupArray[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GroupMessageVC") as!
        GroupMessgaeVC
        
        self.presentVC(viewController: vc)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
