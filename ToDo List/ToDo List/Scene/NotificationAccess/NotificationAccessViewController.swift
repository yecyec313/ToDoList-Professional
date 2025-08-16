//
//  NotificationAccessViewController.swift
//  ToDo List
//
//  Created by alios on 5/16/1404 AP.
//

import UIKit
import Lottie

class NotificationAccessViewController: UIViewController {

   
    @IBAction func nextAction(_ sender: UIButton) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,.badge]){ accessed, error in
            //shart haye zir baraye in hast ke agar karbar taeeid nakard chekar konim
            UserDefaults.isShowNotification = true
            DispatchQueue.main.async{
               self.presentOnboarding()
            }                                                                                      
            // if accessed {
            // }else{
            // }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    @IBOutlet weak var animateView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        
    }
    

  

}
private extension NotificationAccessViewController{
    func setupAnimation(){
        let animation = LottieAnimation.named("Waiting")
        let lottieAnimationView = LottieAnimationView(animation: animation)
        lottieAnimationView.frame = animateView.bounds
        
        animateView.addSubview(lottieAnimationView)
        lottieAnimationView.play()
        lottieAnimationView.loopMode = .loop
    }
    func presentOnboarding(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewControllerID")
        viewController.modalTransitionStyle = .partialCurl
        viewController.modalPresentationStyle = .fullScreen
       present(viewController,animated:  true)
    }
}
