//
//  MainTabbarController.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkNotificationStatus()
        setupNotificationObserver()
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async{
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewControllerID") as! SettingsViewController
                let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
                homeViewController.tabBarItem.title = "home".localized
                homeViewController.tabBarItem.image = UIImage(systemName:  "house")
                settingsViewController.tabBarItem.title = "settings".localized
                
                settingsViewController.tabBarItem.image = UIImage(systemName: "gear")
                let homeNavigationController = UINavigationController(rootViewController: homeViewController)
                let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
                self.viewControllers = [homeNavigationController,settingsNavigationController]
                
            }

        }
        //        homeViewController.title = "Home"
       
//        homeViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: (Any).self], for: .normal)
       
//        settingsViewController.title = "Settings"
      
        
        tabBar.tintColor = UIColor.selectedTabbarItem
        tabBar.semanticContentAttribute = UserDefaults.language == .english ? .forceLeftToRight: .forceRightToLeft
    }
    
    
    func setupNotificationObserver() {
         NotificationCenter.default.addObserver(
             self,
             selector: #selector(appWillEnterForeground),
             name: UIApplication.willEnterForegroundNotification,
             object: nil
         )
     }
    
     @objc func appWillEnterForeground() {
         checkNotificationStatus()
     }
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }


}
