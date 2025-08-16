//
//  SplashViewController.swift
//  ToDo List
//
//  Created by alios on 5/15/1404 AP.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: AppLabel!
    @IBOutlet weak var logoToDo: UIImageView!
    @IBOutlet weak var logoTop: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        UserDefaults.language = .farsi
        versionSetup()
        logoScaleSetup()
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}
// MARK: - private
private extension SplashViewController{
    func logoScaleSetup(){
        logoTop.transform = CGAffineTransform(scaleX: 0, y: 0)
        logoToDo.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    func versionSetup(){
        let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        let attributed = NSAttributedString(string: "version-*".localizedWithArgs([appVersion]),attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        versionLabel.attributedText = attributed
    }
    
    func animate(){
        UIView.animate(withDuration: 1.1,delay: 0, usingSpringWithDamping: 3,initialSpringVelocity: 2,options: [.curveEaseOut]) {
            self.logoTop.transform = CGAffineTransform(scaleX: 1, y: 1).rotated(by: 90)
            self.logoToDo.transform = CGAffineTransform(scaleX: 1, y: 1).rotated(by: 90)
        }completion: { _ in
            UIView.animate(withDuration: 0.5,delay: 0,options: [.curveEaseOut] ){
                self.logoTop.transform = CGAffineTransform(rotationAngle: 0)
                self.logoToDo.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.manageWhereToGo()

                })

                
            }
        }
    }
    func manageWhereToGo(){
        DispatchQueue.global(qos: .userInitiated).async{
            let isShowNot =  UserDefaults.isShowNotification
            let isShowOnboarding = UserDefaults.isShowOnboarding
            DispatchQueue.main.async {
                if isShowNot{
                    if isShowOnboarding{
                        let viewController = MainTabbarController()
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController , animated: true)
                    }else{
                        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewControllerID")
                        viewController.modalTransitionStyle = .partialCurl
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController,animated:  true)
                    }
                    
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: .main)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "NotificationAccessViewControllerID")
                    viewController.modalTransitionStyle = .partialCurl
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController,animated:  true)
                }
            }
            
        }
        
       
    }
}
