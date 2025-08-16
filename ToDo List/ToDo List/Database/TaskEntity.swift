//
//  TaskEntity.swift
//  ToDo List
//
//  Created by alios on 5/21/1404 AP.
//
import CoreData
import UIKit
class AppDatabase{
    private func safeContext() -> NSManagedObjectContext{
        if Thread.isMainThread{
            return appDelegate.persistentContainer.newBackgroundContext()
        }else{
            return context
        }
    }
    internal init(){
        context = appDelegate.persistentContainer.viewContext
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private(set) var context: NSManagedObjectContext!
    static var instance = AppDatabase()
    func clearAllTaskEntity(){
//        let newContext = safeContext()
//        newContext.performAndWait {
            let items = fetchTaskEntity()
            for item in items {
               context.delete(item)
                appDelegate.saveContext()
            }
//        }
    }
    func deleteTaskItem(by id: String){
//        let newContext = safeContext()
//        newContext.performAndWait {
            let items = fetchTaskEntity(by: id)
            if let result = items.first{
                let taskId = result.value(forKey: "id") as? String
                if taskId == id{
                    context.delete(result)
                    let notificationId = "ToDoNotification" + id
                    do{
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
                    }
                    appDelegate.saveContext()
                    return
                }
            }
//        }
    }
    
    func deleteTaskAzTaskEntity(by id: String){
        // in khtaye paeen baraye in hast ke hame item ha fetch nashavad
        var items = fetchTaskEntity(by: id)
        if let result = items.first{
            let taskId = result.value(forKey: "id") as? String
            if taskId == id{
                items.removeAll{ $0.id == taskId}
                appDelegate.saveContext()
                return
            }
        }
    }
    func managedObjectToTaskDataModel() -> [TaskDataModel]{
        let items = fetchTaskEntity()
        var tasks = [TaskDataModel]()
        for itemTask in items{
            let task = TaskDataModel(id: itemTask.value(forKey: "id") as? String ?? "",title: itemTask.value(forKey: "title") as? String ?? "",date: itemTask.value(forKey: "date") as? Date ?? Date())
            tasks.append(task)
        }
        return tasks
    }
    func addTaskEntityToDataBase(taskModels: TaskDataModel){
//        let newContext = safeContext()
//        newContext.performAndWait{
            let taskEntity = TaskEntity(context: context)
            taskEntity.id = taskModels.id
            taskEntity.title = taskModels.title
            taskEntity.date = taskModels.date
            context.insert(taskEntity)
            appDelegate.saveContext()
            if UserDefaults.isAcceptNotification == true,taskModels.date > Date(){
                let content = UNMutableNotificationContent()
                content.title = "To Do Task!"
                content.body = taskModels.title
                let notificationId = "ToDoNotification" + taskModels.id
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: taskModels.date.timeIntervalSince1970 - Date().timeIntervalSince1970, repeats: false )
                let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
                Task{
                    do{
                        try await UNUserNotificationCenter.current().add(request)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            
//        }
    }
    func task(by id: String) -> TaskDataModel?{
        if let itemTask = fetchTaskEntity(by: id).first{
//            let imageItem = ImageItem(context: context)
            let task = TaskDataModel(id: itemTask.value(forKey: "id") as? String ?? "",title: itemTask.value(forKey: "title") as? String ?? "",date: itemTask.value(forKey: "date") as? Date ?? Date())
            return task
        }
        return nil
    }
}
extension AppDatabase{
    func fetchTaskEntity(by id: String? = nil) -> [TaskEntity]{
//        let newContext = safeContext()
        var results: [TaskEntity] = []
//        newContext.performAndWait{
            let request
    //            =GalleryItem.fetchRequest()
            = NSFetchRequest<TaskEntity>(entityName:  "TaskEntity")
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

   

