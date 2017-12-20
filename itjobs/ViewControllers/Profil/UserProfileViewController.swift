//
//  UserProfileViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var name: String = ""
    var logoutReponse = StatusResponse()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
