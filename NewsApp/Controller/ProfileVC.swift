//
//  ProfileVC.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/2/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var logOut: UITableViewCell!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUser()
    }
    
    func updateUser() {
        
        userName.text = user.name
        category.text = user.newsCategory?.string ?? ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // if select log out cell
        if let cell = tableView.cellForRow(at: indexPath),
            cell === logOut {
            
            let alert = UIAlertController(title: "Warning", message: "Are you sure you want to log out", preferredStyle: .alert)
            let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
                // log out
                UserManager.shared.setLoggedIn(user: nil)
                // present log in screen
                (UIApplication.shared.delegate as? AppDelegate)?.launch()
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(cancel)
            alert.addAction(logoutAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
