//
//  UIFont.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import UIKit
extension UIFont{
    class func farsiLabelFont(size: CGFloat = 17) -> UIFont{
        UIFont(name: "IRANYekan Bold",size: size)!
    }
    class func englishLabelFont(size: CGFloat = 17) -> UIFont{
        UIFont.systemFont(ofSize: size)
    }
    class func farsiButtonFont(size: CGFloat = 17) -> UIFont{
        UIFont(name: "IRANYekan Bold",size: size)!
    }
    class func englishButtonFont(size: CGFloat = 17) -> UIFont{
        UIFont.systemFont(ofSize: size)
    }
}
