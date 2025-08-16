//
//  OnboardingViewController.swift
//  ToDo List
//
//  Created by alios on 5/17/1404 AP.
//

import UIKit
import AVFoundation
import AVKit
class OnboardingViewController: UIViewController {

    @IBOutlet weak var startButton: AppButton!
    @IBOutlet weak var containerView: UIView!
    var player: AVPlayer?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
        player = nil
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPlayer()
        // code haye zir baraye mogheeei ast ke bekhahim az ravesh haye herfeeei baraye control kardan video estefade konim
//        super.viewDidAppear(animated)
//        if let url = Bundle.main.url(forResource: "Onboarding", withExtension: "mp4"){
//             player = AVPlayer(url:url)
//            let vc = AVPlayerViewController()
//            vc.player = player
//            present(vc,animated: true)
////                let layer = AVPlayerLayer(player: player)
////                layer.frame = containerView.bounds
////            layer.videoGravity = .resizeAspectFill
////                containerView.layer.addSublayer(layer)
//                player.play()
//        }
//        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main, using: {
//            [weak self] _ in
//            self?.player?.seek(to: CMTime.zero)
//            self?.player?.play()
//        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundNotification()
       setupButton()
       
    }
    private func setupBackgroundNotification() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(appDidEnterForeground),
                name: UIApplication.willEnterForegroundNotification,
                object: nil
            )
    }
    @objc private func appDidEnterForeground() {
            print("enter foreground")
            // اینجا کدهای مورد نظرتان را اضافه کنید
        setupPlayer()
        }
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @IBAction func startButtonTouch(_ sender: Any) {
        UserDefaults.isShowOnboarding = true
        
        let viewController = MainTabbarController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController , animated: true)
    }
    

}
extension OnboardingViewController{
    func setupButton(){
        startButton.layer.cornerRadius = 8
        startButton.layer.shadowColor = UIColor.white.cgColor
        startButton.layer.shadowRadius = 10
        startButton.layer.shadowOpacity = 1
        startButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    func setupPlayer(){
        
        if let url = Bundle.main.url(forResource: "Onboarding", withExtension: "mp4"){
            // code zir check mykonad ke device ipad ast ys no
            if UIDevice.current.userInterfaceIdiom == .pad{
                print("ipad")
            }
             player = AVPlayer(url:url)
                let layer = AVPlayerLayer(player: player)
                layer.frame = containerView.bounds
            layer.videoGravity = .resizeAspectFill
                containerView.layer.addSublayer(layer)
            player?.play()
        }
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main, using: {
            [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        })
    }
}
