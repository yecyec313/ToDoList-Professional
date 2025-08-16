//
//  XIBLocalizable.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import Foundation

@objc protocol XIBLocalizable{
 
    var xibTextStringKey: String?{get set}
    @objc optional var xibPlaceholderStringKey: String?{get set}
}
