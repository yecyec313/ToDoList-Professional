//
//  HomeViewController.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit

class HomeViewController: UIViewController {
    var pendingTasks = [TaskDataModel]()
    var doneTasks = [TaskDataModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        TaskEntityDoneInAppDataBase.instanceTaskEntityDone.clearAllTaskEntityDone()
//        TaskEntityInAppDataBase.instanceTaskEntity.clearAllTaskEntity()
        doneTasks = AppDatabase.instance.managedObjectDoneToTaskDataModel()
        pendingTasks = AppDatabase.instance.managedObjectToTaskDataModel()
        tableView.semanticContentAttribute = UserDefaults.language == .english ? .forceLeftToRight : .forceRightToLeft        
        calculateState()
        addBarButtonItem()
        
    }
   
}
// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Remove"){ (contextualAction, view, boolValue) in
            if indexPath.section == 0{
                let task = self.pendingTasks[indexPath.row]
                AppDatabase.instance.deleteTaskItem(by: task.id)
                self.pendingTasks = self.pendingTasks.filter({ $0.id != task.id })
                self.tableView.reloadData()
                if self.pendingTasks.isEmpty && self.doneTasks.isEmpty{
                    self.inEmptyState()
                }
            }else{
                let task = self.doneTasks[indexPath.row]
                AppDatabase.instance.deleteTaskEntityDone(by: task.id)
                self.doneTasks = self.doneTasks.filter({ $0.id != task.id })
                self.tableView.reloadData()
                if self.pendingTasks.isEmpty && self.doneTasks.isEmpty{
                    self.inEmptyState()
                }
                

            }
            
            
        }
        item.image = UIImage(systemName: "trash.slash")
        item.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [item])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard indexPath.section == 0 else {return nil}
        if indexPath.section == 0{
            let item = UIContextualAction(style: .destructive, title: "Done"){ (contextualAction, view, boolValue) in
                let task = self.pendingTasks[indexPath.row]
                AppDatabase.instance.deleteTaskItem(by: task.id)
                self.pendingTasks = self.pendingTasks.filter({ $0.id != task.id })
                self.doneTasks.append(task)
                AppDatabase.instance.addTaskEntityDoneToDataBase(taskModels: task)
                self.tableView.reloadData()
                
            }
            item.image = UIImage(systemName: "checkmark")
            item.backgroundColor = UIColor.selectedTabbarItem
            return UISwipeActionsConfiguration(actions: [item])
        }else{
            let item = UIContextualAction(style: .destructive, title: "Pending"){ (contextualAction, view, boolValue) in
                let task = self.doneTasks[indexPath.row]
                AppDatabase.instance.deleteTaskEntityDone(by: task.id)
                self.doneTasks = self.doneTasks.filter({ $0.id != task.id })
                self.pendingTasks.append(task)
                AppDatabase.instance.addTaskEntityToDataBase(taskModels: task)
                self.tableView.reloadData()
                
            }
            item.image = UIImage(systemName: "clock")
            item.backgroundColor = UIColor.selectedTabbarItem
            return UISwipeActionsConfiguration(actions: [item])
        }
       
    }
}
// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        pendingTasks.isEmpty && doneTasks.isEmpty ? 0 : 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return pendingTasks.count
        }else{
            return doneTasks.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCellID",for: indexPath) as!
        TaskTableViewCell
        if indexPath.section == 0{
            cell.configurePending(task: pendingTasks[indexPath.row])
        }else{
            cell.configureDone(task: doneTasks[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "pending-tasks".localized
        }else {
            return "done-tasks".localized
        }
    }
    
}
// MARK: - AddTaskDelegate
extension HomeViewController: AddTaskDelegate{
    func add(task: TaskDataModel){
        pendingTasks.append(task)
        AppDatabase.instance.addTaskEntityToDataBase(taskModels: task)

        tableView.reloadData()
        hasDataState()
        
        
        
    }
}
// MARK: - private
private extension HomeViewController{
    func calculateState(){
        if AppDatabase.instance.managedObjectToTaskDataModel().isEmpty && AppDatabase.instance.managedObjectDoneToTaskDataModel().isEmpty{
            inEmptyState()
        }else{
            hasDataState()
        }
    }

    func inEmptyState(){
        tableView.setEmptyMessage(message: "no-tasks".localized)
        
    }
    func hasDataState(){
        tableView.clearBackground()
    }
    func addBarButtonItem(){
        let button = UIBarButtonItem(image: UIImage.addTaskBarButtonItemIcon
                                     , style: .done
                                     , target: self
                                     , action: #selector(addButtonTouch))
        button.tintColor = .addTaskBarButtonItemColor
        if UserDefaults.language == .english{
            navigationItem.rightBarButtonItem = button
            
        }else{
            navigationItem.leftBarButtonItem = button
        }
    }
    @objc func addButtonTouch(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AddTaskViewControllerID") as! AddTaskViewController
        viewController.delegate = self
        present(viewController, animated: true)
    }
}
