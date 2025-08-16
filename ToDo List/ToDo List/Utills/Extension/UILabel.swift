//
//  UILabel.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import UIKit

extension UILabel: XIBLocalizable{
    @IBInspectable var xibTextStringKey: String?{
        get {self.xibTextStringKey}
        set {
            if let newValue{
                text = newValue.localized
            }
        }
    }
}
