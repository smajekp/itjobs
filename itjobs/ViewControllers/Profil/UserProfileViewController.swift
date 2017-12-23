//
//  UserProfileViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var userResponse: User!
    
    var activityView = UIActivityIndicatorView()
    
    let defaults = UserDefaults.standard
    var logoutReponse = StatusResponse()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.stackView.isHidden = true
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityView.center = CGPoint(x: self.view.center.x,y: 150);
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        let user_id = defaults.object(forKey: "user_id") as? String
        if let user_id = user_id {
            getUser(userId: Int(user_id)!)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func getUser(userId: Int) {
        let userService = UserService()
        userService.getUser(userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.userResponse = responseObject
                    
                    self.name.text = self.userResponse.name
                    self.email.text = self.userResponse.email
                    self.date.text = self.userResponse.create_date
                    
                    self.stackView.isHidden = false
                    self.activityView.removeFromSuperview()
                }
            }
            return
        })
    }
    
}
