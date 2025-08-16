//
//  TaskTableViewCell.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

 
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: AppLabel!
    @IBOutlet weak var dataLabel: AppLabel!
    var task: TaskDataModel!
    func configurePending(task: TaskDataModel){
        self.task = task
        if let taskEntity = AppDatabase.instance.task(by: task.id){
            titleLabel.text = taskEntity.title
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd yyyy HH:mm"
            // khat zir kar kardan ba taghvim farsi
//            dateFormatter.calendar = Calendar(identifier: .persian)
            dataLabel.text = dateFormatter.string(from: taskEntity.date)
//            dataLabel.text = taskEntity.date.formatted(date: .numeric, time: .standard)
            titleLabel.textAlignment = UserDefaults.language == .english ? .left : .right
            dataLabel.textAlignment = UserDefaults.language == .english ? .left : .right
        }
//            titleLabel.text = task.title
//            dataLabel.text = task.date.formatted(date: .numeric, time: .standard)
//            titleLabel.textAlignment = UserDefaults.language == .english ? .left : .right
//            dataLabel.textAlignment = UserDefaults.language == .english ? .left : .right
        
        
    }
    override func prepareForReuse(){
         super.prepareForReuse()
        titleLabel.text = nil
        dataLabel.text = nil
        //baraye beham narikhte shodam dade ha bad scroll
    }

    func configureDone(task: TaskDataModel){
        self.task = task
        if let taskEntity = AppDatabase.instance.taskDone(by: task.id){
            titleLabel.text = taskEntity.title
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd yyyy HH:mm"
            dataLabel.text = dateFormatter.string(from: taskEntity.date)
//            dataLabel.text = taskEntity.date.formatted(date: .numeric, time: .standard)
            titleLabel.textAlignment = UserDefaults.language == .english ? .left : .right
            dataLabel.textAlignment = UserDefaults.language == .english ? .left : .right
        }
//            titleLabel.text = task.title
//            dataLabel.text = task.date.formatted(date: .numeric, time: .standard)
//            titleLabel.textAlignment = UserDefaults.language == .english ? .left : .right
//            dataLabel.textAlignment = UserDefaults.language == .english ? .left : .right
        
        
    }
    


}

