//
//  RelationTask.swift
//  ToDo List
//
//  Created by alios on 5/21/1404 AP.
//
import CoreData
import Foundation
extension AppDatabase{
    func addTaskToTaskDone(taskModel: TaskDataModel){
        if let taskItem = fetchTaskEntity(by: taskModel.id).first{
            let taskDoneItem = TaskEntityDone(context: context)
            taskDoneItem.title = taskModel.title
            taskDoneItem.id = taskModel.id
            taskDoneItem.date = taskModel.date
            //khat paeen marmot be imageRelation ast
//                galleryItem.addToImage(imageItem)
            taskItem.taskdone = taskDoneItem
            appDelegate.saveContext()
        }
        
    }
}
extension AppDatabase{
    func addTaskDoneToTask(taskModel: TaskDataModel){
        if let taskDoneItem = fetchTaskEntityDone(by: taskModel.id).first{
            let taskItem = TaskEntity(context: context)
            taskItem.title = taskModel.title
            taskItem.id = taskModel.id
            taskItem.date = taskModel.date
            //khat paeen marmot be imageRelation ast
//                galleryItem.addToImage(imageItem)
            taskDoneItem.task = taskItem
            appDelegate.saveContext()
        }
        
    }
}
