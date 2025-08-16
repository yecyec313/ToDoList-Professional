//
//  LocaleEnum.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import Foundation

enum LocaleEnum: String{
    case farsi
    case english
    var tableName: String{
        switch self{
        case .farsi:
            return "Farsi"
        case .english:
            return "English"
        }
    }
}
