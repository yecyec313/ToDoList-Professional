//
//  TaskEntityDone.swift
//  ToDo List
//
//  Created by alios on 5/21/1404 AP.
//
import CoreData

import UIKit
// MARK: - AppDatabase for TaskEntityDone
extension AppDatabase{
    func clearAllTaskEntityDone(){
//        let newContext = safeContext()
//        newContext.performAndWait{
            let items = fetchTaskEntityDone()
            for item in items {
               context.delete(item)
                appDelegate.saveContext()
            }
//        }
    }
    func deleteTaskAzTaskEntityDone(by id: String){
        // in khtaye paeen baraye in hast ke hame item ha fetch nashavad
        var items = fetchTaskEntityDone(by: id)
        if let result = items.first{
            let taskId = result.value(forKey: "id") as? String
            if taskId == id{
                items.removeAll{ $0.id == taskId}
                appDelegate.saveContext()
                return
            }
        }
  
    }
    func taskDone(by id: String) -> TaskDataModel?{
        if let itemTask = fetchTaskEntityDone(by: id).first{
//            let imageItem = ImageItem(context: context)
            let task = TaskDataModel(id: itemTask.value(forKey: "id") as? String ?? "",title: itemTask.value(forKey: "title") as? String ?? "",date: itemTask.value(forKey: "date") as? Date ?? Date())
            return task
        }
        return nil
    }
    func managedObjectDoneToTaskDataModel() -> [TaskDataModel]{
        let items = fetchTaskEntityDone()
        var tasks = [TaskDataModel]()
        for itemTask in items{
            let task = TaskDataModel(id: itemTask.value(forKey: "id") as? String ?? "",title: itemTask.value(forKey: "title") as? String ?? "",date: itemTask.value(forKey: "date") as? Date ?? Date())
        tasks.append(task)
        }
        return tasks
    }
    func addTaskEntityDoneToDataBase(taskModels: TaskDataModel){
//        let newContext = safeContext()
//        newContext.performAndWait{
            let taskEntity = TaskEntityDone(context: context)
            taskEntity.id = taskModels.id
            taskEntity.title = taskModels.title
            taskEntity.date = taskModels.date
            context.insert(taskEntity)
            appDelegate.saveContext()
//        }
    }
    func deleteTaskEntityDone(by id: String){
        
        // in khtaye paeen baraye in hast ke hame item ha fetch nashavad
//        let newContext = safeContext()
//        newContext.performAndWait {
            let items = fetchTaskEntityDone(by: id)
            if let result = items.first{
                let taskId = result.value(forKey: "id") as? String
                if taskId == id{
                    context.delete(result)
                    appDelegate.saveContext()
                    return
                }
            }
//        }
    }
    func fetchTaskEntityDone(by id: String? = nil) -> [TaskEntityDone]{
//        let newContext = safeContext()
        var results: [TaskEntityDone] = []
//        newContext.performAndWait{
            let request = NSFetchRequest<TaskEntityDone>(entityName:  "TaskEntityDone")
            if let id{
                request.predicate = NSPredicate(format: "id == %@", id)
            }
            do{
                results = try context.fetch(request)
            }catch{
                print(error)
               results = []
            }
//        }
       return results
    }
}

