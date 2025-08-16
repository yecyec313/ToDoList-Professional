//
//  UIButton.swift
//  ToDo List
//
//  Created by alios on 5/16/1404 AP.
//

import UIKit

extension UIButton: XIBLocalizable{
    @IBInspectable var xibTextStringKey: String?{
        get {self.xibTextStringKey}
        set{
            if let newValue{
                setTitle(newValue.localized, for: .normal)
            }
        }
    }
}
