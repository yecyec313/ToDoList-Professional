//
//  AppLabel.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import UIKit
class AppLabel: UILabel{
    override func awakeFromNib() {
        DispatchQueue.global(qos: .userInitiated).async {
            let customFont = UserDefaults.language == .english ? UIFont.englishLabelFont() : UIFont.farsiLabelFont()
            DispatchQueue.main.async{
                self.font = customFont

            }
        }
     
    }
}

