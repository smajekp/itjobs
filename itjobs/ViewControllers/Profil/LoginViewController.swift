//
//  LoginViewController.swift
//  itjobs
//
//  Created by Piotrek on 09.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import PKHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let defaults = UserDefaults.standard
    var loginResponse = LoginResponse()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let isLogged = defaults.object(forKey: "logged") as? Bool
        if let isLogged = isLogged {
            if (isLogged) {
                showUserProfileVC()
            }
        }
        setPlaceholdersColorsAndBorderBottom()
    }
    
    func setPlaceholdersColorsAndBorderBottom() {
        loginTextField.placeholderColor(color: UIColor.white)
        loginTextField.setBottomBorder()
        
        passwordTextField.placeholderColor(color: UIColor.white)
        passwordTextField.setBottomBorder()
    }
    
    func showUserProfileVC() {
        let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        self.navigationController?.setViewControllers([userProfileViewController], animated: false)
    }
    
    func login(email: String, password: String) {
        let loginService = LoginService()
        loginService.login(email: email, password: password, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.loginResponse = responseObject
                    
                    if (self.loginResponse.status == "Email or password is incorrect") {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.errorMessage(title: "Błąd!", body: "Podane dane są nieprawidłowe")
                    } else if (self.loginResponse.status == "true") {
                        self.defaults.set(true, forKey: "logged")
                        self.defaults.set(self.loginResponse.user_id!, forKey: "user_id")
                        
                        let swiftMessage = SwiftMessage()
                        swiftMessage.successMessage(title: "Super!", body: "Zalogowano pomyślnie")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            swiftMessage.hideMessage()
                            let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
                            self.navigationController?.setViewControllers([userProfileViewController], animated: true)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        login(email: loginTextField.text!, password: passwordTextField.text!)
        textField.resignFirstResponder()
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        login(email: loginTextField.text!, password: passwordTextField.text!)
    }
    
}
