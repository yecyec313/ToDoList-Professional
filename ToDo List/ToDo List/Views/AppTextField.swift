//
//  AppTextField.swift
//  ToDo List
//
//  Created by alios on 5/22/1404 AP.
//

import UIKit
class AppTextField: UITextField{
    override func awakeFromNib() {
        textAlignment = UserDefaults.language == .english ? .left: .right
    }
}
