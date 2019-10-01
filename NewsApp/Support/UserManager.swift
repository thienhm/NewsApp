//
//  UserManager.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/2/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import Foundation
import ObjectMapper

class UserManager {
    
    static let shared = UserManager()
    
    enum Keys: String {
        
        case users = "Users"
        case currentUser = "CurrentUser"
        
        var string: String {
            return self.rawValue
        }
    }
    
    var currentUser: User? {
        
        if let userName = UserDefaults.standard.string(forKey: Keys.currentUser.string) {
            return getUsers().first(where: {$0.name == userName})
        }
        return nil
    }
    
    func addNew(user: User) {
        
        var users = getUsers()
        
        users.append(user)
        
        saveUsers(users: users)
    }
    
    func login(userName: String, password: String) -> User? {
        
        if let user = getUsers().first(where: {$0.name == userName && $0.password == password }) {
            
            setLoggedIn(user: user)
            return user
        }
        
        return nil
    }
    
    func setLoggedIn(user: User?) {
        
        UserDefaults.standard.set(user?.name, forKey: Keys.currentUser.string)
    }
    
    private func getUsers() -> [User] {
        
        if let usersJson = UserDefaults.standard.string(forKey: Keys.users.string) {
            
            return [User](JSONString: usersJson) ?? []
        }
        
        return []
    }
    
    private func saveUsers(users: [User]) {
        
        UserDefaults.standard.set(users.toJSONString(), forKey: Keys.users.string)
    }
    
}
