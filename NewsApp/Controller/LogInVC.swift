//
//  LogInVC.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/2/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit

protocol LoginDelegate: class {
    func loginVC(didLoginWithUser: User)
}

class LogInVC: UITableViewController, CategoryDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var category: UILabel!
    
    weak var delegate: LoginDelegate?
    
    var isSignUp = false {
        didSet {
            setupVC()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVC()
    }
    
    private func setupVC() {
        
        title = isSignUp ? "Sign Up" : "Login"
        
        if isSignUp {
            title = "Sign Up"
            navigationItem.leftBarButtonItem?.title = "Cancel"
            navigationItem.rightBarButtonItem?.title = "Save"
            
        }
        else {
            title = "Login"
            navigationItem.leftBarButtonItem?.title = "Sign Up"
            navigationItem.rightBarButtonItem?.title = "Login"
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return isSignUp ? 3 : 2
    }

    // MARK: - User Event
    
    @IBAction func on(left: UIBarButtonItem) {
        
        // Toggle Login/ Sign Up state
        isSignUp = !isSignUp
    }

    @IBAction func on(right: UIBarButtonItem) {
        
        // login /  sign up
        isSignUp ? signup() : login()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let categoryVC = segue.destination as? CategoryVC {
            categoryVC.delegate = self
        }
    }
    
    // MARK: - Func
    
    private func login() {
        
        guard validate() else {
            return
        }
        
        let name = userName.text ?? ""
        let pass = password.text ?? ""
        
        // login
        if let user = UserManager.shared.login(userName: name, password: pass) {
            // callback to show home screen
            delegate?.loginVC(didLoginWithUser: user)
        }
    }
    
    private func signup() {
        
        guard validate() else {
            return
        }
        
        let name = userName.text ?? ""
        let pass = password.text ?? ""
        let cate = NewsCategory(rawValue: (category.text ?? "").lowercased())!
        
        let newUser = User(name: name, password: pass, category: cate)
        
        // save to user default
        UserManager.shared.addNew(user: newUser)
        
        // login with new user
        login()
    }
    
    private func validate() -> Bool {
        
        guard !(userName.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        guard !(password.text ?? "").isEmpty else {
            return false
        }
        
        guard !isSignUp || NewsCategory(rawValue: (category.text ?? "").lowercased()) != nil else {
            return false
        }
        
        return true
    }
    
    // Category Delegate
    func categoryVC(didSelectCategory: String) {
        
        category.text = didSelectCategory
    }
}
