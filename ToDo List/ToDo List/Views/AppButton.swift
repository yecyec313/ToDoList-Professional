//
//  AppButton.swift
//  ToDo List
//
//  Created by alios on 5/16/1404 AP.
//

import UIKit

class AppButton: UIButton{
    override func awakeFromNib(){
        titleLabel?.font = UserDefaults.language == .english ? UIFont.englishButtonFont(size: titleLabel?.font.pointSize ?? 17) : UIFont.farsiButtonFont(size: titleLabel?.font.pointSize ?? 17)
    }
}
