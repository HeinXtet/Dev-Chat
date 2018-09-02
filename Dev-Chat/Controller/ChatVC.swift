//
//  ChatVC.swift
//  Dev-Chat
//
//  Created by HeinHtet on 9/2/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let textMessage = [
        " This how work for chat messsage view for swift ",
         " This how work for chat messsage view for swift  This how work for chat messsage view for swift ",
          " This how work for chat messsage view for swift This how work for chat messsage view for swift This how work for chat messsage view for swift",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }
}

extension ChatVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  textMessage.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.isYour(your: true, messageTv: textMessage[indexPath.row])
        return cell
    }
    
}
