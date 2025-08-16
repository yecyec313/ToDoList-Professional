//
//  AddTaskViewController.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit
protocol AddTaskDelegate: AnyObject{
    func add(task: TaskDataModel)
}
class AddTaskViewController: UIViewController {

    @IBOutlet weak var label: AppLabel!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    weak var delegate: AddTaskDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.textAlignment = UserDefaults.language == .english ? .left : .right
        titleTextField.delegate = self
        pickerView.minimumDate = Date()
     
    }
    

    @IBAction func continueButtonTouch(_ sender: Any) {
        if !(titleTextField.text ?? "").isEmpty{
            delegate.add(task: TaskDataModel(title: titleTextField.text ?? "", date: pickerView.date))
            // code zir baraye rokh nadadan memory lick ast
            dismiss(animated: true)
        }
    }
    

}
extension AddTaskViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
