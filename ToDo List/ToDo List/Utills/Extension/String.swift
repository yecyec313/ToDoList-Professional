//
//  String.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import Foundation

extension String{
    var localized: String{
        Localizable.getLocalizedString(type: UserDefaults.language, key: self)
    }
    func localizedWithArgs(_ args: [String]) -> String{
        Localizable.getLocalizedStringWithArgs(type: UserDefaults.language, key: self, args: args)
    }
}
