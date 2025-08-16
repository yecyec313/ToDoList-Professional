//
//  UIImage.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit

extension UIImage{
    private class var plusIcon: UIImage{
        UIImage(systemName: "plus")!
    }
    class var addTaskBarButtonItemIcon: UIImage{
        plusIcon
    }
}
