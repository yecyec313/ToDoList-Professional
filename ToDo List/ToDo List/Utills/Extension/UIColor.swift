//
//  UIColor.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit
extension UIColor{
    static let appPurple: UIColor = {
        return  UIColor(named: "Purple")!
        
    }()
//    private class var appPurple: UIColor{
//        UIColor(named: "Purple")!
//    }
    class var selectedTabbarItem: UIColor{
        .appPurple
    }
    class var addTaskBarButtonItemColor: UIColor{
        .appPurple
    }
}

