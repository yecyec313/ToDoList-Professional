//
//  UserDefaults.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import Foundation

extension UserDefaults{
    struct UserDefaultKeys{
        static let language = "language"
        static let notification = "notification"
        static let onboarding = "onboarding"
        static let isAccept = "accept"
        
    }
    class var isAcceptNotification: Bool{
        get {
            if let notification = UserDefaults.standard.object(forKey: UserDefaults.UserDefaultKeys.isAccept) as? Bool{
                return notification
            }else{
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.UserDefaultKeys.isAccept)
        }
    }
    class func clearAll(){
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultKeys.notification)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultKeys.language)
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultKeys.onboarding)

    }
   
    class var language: LocaleEnum {
        get {
            if let language = UserDefaults.standard.string(forKey: UserDefaults.UserDefaultKeys.language){
                return LocaleEnum(rawValue: language) ?? .english
            }else{
                return .english
            }
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaults.UserDefaultKeys.language)
        }
    }
    class var isShowOnboarding: Bool{
        get {
            if let notification = UserDefaults.standard.object(forKey: UserDefaults.UserDefaultKeys.onboarding) as? Bool{
                return notification
            }else{
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.UserDefaultKeys.onboarding)
        }
    }
    class var isShowNotification: Bool{
        get {
            if let notification = UserDefaults.standard.object(forKey: UserDefaults.UserDefaultKeys.notification) as? Bool{
                return notification
            }else{
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.UserDefaultKeys.notification)
        }
    }
}
