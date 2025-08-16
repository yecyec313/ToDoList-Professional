//
//  Localizable.swift
//  ToDo List
//
//  Created by alios on 5/14/1404 AP.
//

import Foundation

class Localizable{
    class func getLocalizedString(type: LocaleEnum, key: String) -> String{
        NSLocalizedString(key,tableName: type.tableName, comment: "")
    }
    class func getLocalizedStringWithArgs(type: LocaleEnum,key: String,args:[String]) -> String{
        String(format: getLocalizedString(type: type, key: key), arguments: args)
    }
    
}
