//
//  TaskDataModel.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import Foundation

struct TaskDataModel{
    var id: String  = UUID().uuidString
    var title: String
    var date: Date
}
