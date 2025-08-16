//
//  UserNotifications.swift
//  ToDo List
//
//  Created by alios on 5/22/1404 AP.
//

import Foundation
import UserNotifications



func checkNotificationStatus() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        DispatchQueue.main.async {
            switch settings.authorizationStatus {
            case .authorized:
                UserDefaults.isAcceptNotification = true
                print("نوتیفیکیشن فعال است")
                // کدهای مربوط به زمانی که نوتیفیکیشن فعال است
            case .denied:
                print("کاربر نوتیفیکیشن را غیرفعال کرده است")
                UserDefaults.isAcceptNotification = false
                // کدهای مربوط به زمانی که نوتیفیکیشن غیرفعال است
            case .notDetermined, .provisional, .ephemeral:
                UserDefaults.isAcceptNotification = false
                print("وضعیت نامشخص یا موقت")
            @unknown default:
                UserDefaults.isAcceptNotification = false
                print("وضعیت ناشناخته")
            }
        }
    }
}
