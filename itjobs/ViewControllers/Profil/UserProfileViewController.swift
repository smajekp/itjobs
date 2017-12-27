//
//  UserProfileViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import SKPhotoBrowser

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var addCVButton: UIButton!
    @IBOutlet weak var deleteCVButton: UIButton!
    @IBOutlet weak var loadingPhotoLabel: UILabel!
    @IBOutlet weak var cvView: UIView!
    @IBOutlet weak var showMyTests: UIButton!
    @IBOutlet weak var showUsersTests: UIButton!
    @IBOutlet weak var createTests: UIButton!
    
    var userResponse: User!
    var cvResponse: CV!
    var updateResponse: StatusResponse!
    
    var activityView = UIActivityIndicatorView()
    var activityViewImage = UIActivityIndicatorView()
    
    let defaults = UserDefaults.standard
    var logoutReponse = StatusResponse()
    
    let imagePicker = UIImagePickerController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.userView.isHidden = true
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityView.center = CGPoint(x: self.view.center.x,y: 150);
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        let user_type = defaults.object(forKey: "user_type") as? String
        if user_type != nil {
            if (user_type == "user") {
                showUsersTests.isHidden = true
                createTests.isHidden = true
            } else {
                cvView.isHidden = true
                showMyTests.isHidden = true
            }
        }
            
        let user_id = defaults.object(forKey: "user_id") as? String
        if let user_id = user_id {
            getUser(userId: Int(user_id)!)
            getCV(userId: Int(user_id)!)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.loadingPhotoLabel.isHidden = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(UserProfileViewController.tapDetected))
        self.image.isUserInteractionEnabled = true
        self.image.addGestureRecognizer(singleTap)
        
    }
    
    //Action
    @objc func tapDetected() {
        // 1. create SKPhoto Array from UIImage
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(self.image.image!)// add some UIImage
        images.append(photo)
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        self.present(browser, animated: true, completion: {})
    }

    @IBAction func loadImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func deleteCVTapped(_ sender: Any) {
        let user_id = self.defaults.object(forKey: "user_id") as? String
        if let user_id = user_id {
            self.updateCV(userId: Int(user_id)!, cv: "")
            self.image.image = nil
            self.deleteCVButton.isHidden = true
            self.addCVButton.isHidden = false
            
            let urlString: String = Constants.baseURLImages + "no-cv-image.png"
            let imageUrl = URL(string: urlString)
            let image = UIImage(named: "placeholder-image")
            self.image.kf.setImage(with: imageUrl, placeholder: image)
        }
    }
    
    @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.contentMode = .scaleToFill
            let imgData = UIImageJPEGRepresentation(pickedImage, 0.2)!
            
            let uuid = NSUUID().uuidString + ".jpg"
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "fileset",fileName: uuid, mimeType: "image/jpg")
            },
                             to:"http://vps447923.ovh.net/images/uploadimages.php")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    self.loadingPhotoLabel.isHidden = false
                    self.activityViewImage = UIActivityIndicatorView(activityIndicatorStyle: .white)
                    self.activityViewImage.center = CGPoint(x: self.image.center.x,y: self.image.center.y - 225);
                    self.activityViewImage.startAnimating()
                    self.image.addSubview(self.activityViewImage)
                    
                    self.addCVButton.isHidden = true
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response.result.value)
                        self.activityViewImage.removeFromSuperview()
                        self.image.image = pickedImage
                        
                        let user_id = self.defaults.object(forKey: "user_id") as? String
                        if let user_id = user_id {
                            self.updateCV(userId: Int(user_id)!, cv: uuid)
                        }
                        self.deleteCVButton.isHidden = false
                        self.loadingPhotoLabel.isHidden = true
    
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showFavourites(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        let user_id = defaults.object(forKey: "user_id") as? String
        if let user_id = user_id {
            logout(user_id: user_id)
        }
    }
    
    func logout(user_id: String) {
        let loginService = LoginService()
        loginService.logout(user_id: user_id, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.logoutReponse = responseObject
                    
                    if (self.logoutReponse.status == "Logout success") {
                        self.defaults.set(false, forKey: "logged")
                        self.defaults.set("", forKey: "user_id")
                        self.defaults.set("", forKey: "user_type")
                        
                        let swiftMessage = SwiftMessage()
                        swiftMessage.successMessage(title: "Super!", body: "Wylogowano pomyślnie")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            swiftMessage.hideMessage()
                            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            self.navigationController?.setViewControllers([loginViewController], animated: false)
                        })
                        
                        
                    } else {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.errorMessage(title: "Błąd!", body: "Wystąpił nieoczekiwany błąd")
                    }
                }
            }
            return
        })
    }
    
    func updateCV(userId: Int, cv: String) {
        let userService = UserService()
        userService.updateCV(userId: userId, cv: cv, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.updateResponse = responseObject
                }
            }
            return
        })
    }
    
    func getUser(userId: Int) {
        let userService = UserService()
        userService.getUser(userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.userResponse = responseObject
                    
                    self.name.text = self.userResponse.name
                    self.email.text = self.userResponse.email
                    self.date.text = self.userResponse.create_date
                    
                    self.userView.isHidden = false
                    self.activityView.removeFromSuperview()
                }
            }
            return
        })
    }
    
    func getCV(userId: Int) {
        let userService = UserService()
        userService.getCV(userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.cvResponse = responseObject
                           
                    if (self.cvResponse.cv != nil) {
                        let urlString: String = Constants.baseURLImage + self.cvResponse.cv!
                        let imageUrl = URL(string: urlString)
                        let image = UIImage(named: "placeholder-image")
                        self.image.kf.setImage(with: imageUrl, placeholder: image)
                        self.addCVButton.isHidden = true
                    } else {
                        let urlString: String = Constants.baseURLImages + "no-cv-image.png"
                        let imageUrl = URL(string: urlString)
                        let image = UIImage(named: "placeholder-image")
                        self.image.kf.setImage(with: imageUrl, placeholder: image)
                        self.deleteCVButton.isHidden = true
                    }
                    
                }
            }
            return
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "testUserResultSegue" {
            if (segue.destination is TestUserResultsTableViewController) {
                let tableViewController = segue.destination as? TestUserResultsTableViewController
                
                let backItem = UIBarButtonItem()
                backItem.title = "Powrót"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
}
