//
//  MoreViewController.swift
//  Swift-TableView-Example
//
//  Created by Bilal ARSLAN on 12/10/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

struct UserOption {
    let name: String
    let thumbnails: String
    let index: Int
}

class UserViewController: UITableViewController{
    
    var userOptions = [UserOption]()
    let identifier: String = "UsertableCell"
    
    @IBAction func LogOutAction(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.title = "User"
        initializeTheUserOptions()
    }
    
    func initializeTheUserOptions() {
        self.userOptions = [UserOption(name: "訂單", thumbnails: "layer.png", index: 1),
                            UserOption(name: "關於", thumbnails: "question.png", index: 2),
        ]
        
        self.tableView.reloadData()
    }
    
    // MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? UserTableCell
        cell.configurateTheCell(userOptions[indexPath.row])
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOptions.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            userOptions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    // MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserOrder" {
            let indexPath = self.tableView!.indexPathForSelectedRow
            let destinationViewController: UserOrderViewController = segue.destination as! UserOrderViewController
            //destinationViewController.userOptions = userOptions[indexPath!.row]
        }
    }

}
