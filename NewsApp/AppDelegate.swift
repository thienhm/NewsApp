//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        launch()
        
        return true
    }
    
    func launch() {
        
        window?.makeKeyAndVisible()
        
        // if logged in
        if let _ = UserManager.shared.currentUser {
            
            let tabbarVC = UITabBarController()
            
            tabbarVC.viewControllers = [initTopHeadline(), initCustomNews(), initProfile()]
            
            self.window?.rootViewController = tabbarVC
        }
        else {
            launchLogin()
        }
    }
    
    private func launchLogin() {
        
        let loginNavigation = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
        
        if let loginVC = loginNavigation.viewControllers.first as? LogInVC {
            loginVC.delegate = self
        }
        
        window?.rootViewController = loginNavigation
    
    }
    
    func loginVC(didLoginWithUser: User) {
        
        launch()
    }
    
    private func initTopHeadline() -> UIViewController {
        
        let newListNavigation = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsListNavigation") as! UINavigationController
        newListNavigation.tabBarItem.title = "Top Headline"
        
        return newListNavigation
    }
    
    private func initCustomNews() -> UIViewController {
        
        let newListNavigation = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsListNavigation") as! UINavigationController
        newListNavigation.tabBarItem.title = "Custom News"
        
        if let newsListVC = newListNavigation.viewControllers.first as? NewsListVC {
            newsListVC.category = UserManager.shared.currentUser?.newsCategory
        }
        
        return newListNavigation
    }
    
    private func initProfile() -> UIViewController {
        
        let profileNavigation = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileNavigation") as! UINavigationController
        profileNavigation.tabBarItem.title = "Profile"
        
        if let profileVC = profileNavigation.viewControllers.first as? ProfileVC {
            profileVC.user = UserManager.shared.currentUser!
        }
        
        return profileNavigation
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

