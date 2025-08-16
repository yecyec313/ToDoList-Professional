//
//  UITableView.swift
//  ToDo List
//
//  Created by alios on 5/19/1404 AP.
//

import UIKit

extension UITableView{
    func setEmptyMessage(message: String){
        let messageLabel = AppLabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        backgroundView = messageLabel
        separatorStyle = .none
    }
    func clearBackground(){
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
