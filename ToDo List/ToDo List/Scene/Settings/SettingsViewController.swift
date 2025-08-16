//
//  SettingsViewController.swift
//  ToDo List
//
//  Created by alios on 5/22/1404 AP.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var buttonImageProfile: UIButton!
    
    @IBOutlet weak var telegramView: UIButton!
    @IBOutlet weak var shareView: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        setupViewForTap()
        setupViews()
       
      
    }
    
    @IBAction func telegramButtonTouch(_ sender: Any) {
       
        //code zir marbot be vahve vasl shodan be telegram ast albate dar sorat nasb bodan roye goshi
        if UserDefaults.isAcceptNotification == true{
            if let url = URL(string: "tg://msg?text=something&to=+98123456789"), UIApplication.shared.canOpenURL(url){
                
                    UIApplication.shared.open(url)
                
            }else if let url2 = URL(string: "https://www.apple.com"){
                if UIApplication.shared.canOpenURL(url2){
                    UIApplication.shared.open(url2)

                }
            }
        }else{
            if let settingsURL = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(settingsURL)
            }
        }
        
//        else
//        if let appStoreURL = URL(string: "itms-apps://apple.com"){
//            UIApplication.shared.open(appStoreURL)
//        }
       
            
    
    }
    
    @IBAction func shareButtonTouch(_ sender: Any) {
        if let image = profileImageView.image{
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            //code zir taeein myshavad ke ba text chekar konim nasalan postToTwitter
    //        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToHomeScreen]
            activityViewController.popoverPresentationController?.sourceView = shareView
            present(activityViewController, animated: true)
        }
       
    }
    @IBAction func profileButtonTouch(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style:  .default){ action in
            self.openCamera()
            
            
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){ action in
            self.openGallery()
         
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        // dorost shodan code in ipad
        actionSheet.popoverPresentationController?.sourceView = profileImageView
        present(actionSheet,animated: true)
    }
    
}
private extension SettingsViewController{
    @objc func viewTapped1(){
        containerView.endEditing(true)
        view.endEditing(true)
    }
    func setupViewForTap(){
        let tap = UITapGestureRecognizer(target:  self, action: #selector(viewTapped1)
        )
        containerView.addGestureRecognizer(tap)
//        view.addGestureRecognizer(tap)
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let pickerViewController = UIImagePickerController()
            pickerViewController.delegate = self
            pickerViewController.sourceType = .camera
            pickerViewController.cameraCaptureMode = .photo
            pickerViewController.popoverPresentationController?.sourceView = profileImageView
            present(pickerViewController,animated: true)

        }else{
            print(" not available")
        }
        
    }
    func openGallery(){
        let pickerViewController = UIImagePickerController()
        pickerViewController.delegate = self
        pickerViewController.sourceType = .photoLibrary
        pickerViewController.popoverPresentationController?.sourceView = profileImageView
//        pickerViewController.cameraCaptureMode = .photo
        present(pickerViewController, animated:  true)
//        buttonImageProfile.isHidden = true

    }
    func setupViews(){
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        profileImageView.layer.cornerRadius = 35
    }

}
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            profileImageView.image = image
            profileImageView.contentMode = .scaleAspectFill
            buttonImageProfile.setTitle("", for: .normal)
            
        }
        picker.dismiss(animated: true)
        
    }
}
extension SettingsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        containerView?.endEditing(true)
        return true
    }
}
