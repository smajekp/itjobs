//
//  LoginViewController.swift
//  itjobs
//
//  Created by Piotrek on 09.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isLogged = defaults.object(forKey: "logged") as? Bool
        if let isLogged = isLogged {
            if (isLogged) {
                showUserProfileVC()
            }
        }
        //setPlaceholdersForTextFields()
    }
    
    func setPlaceholdersForTextFields() {
        if let placeholderLogin = loginTextField.placeholder {
            loginTextField.attributedPlaceholder = NSAttributedString(string:placeholderLogin,
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        
        if let placeholderLogin = passwordTextField.placeholder {
            passwordTextField.attributedPlaceholder = NSAttributedString(string:placeholderLogin,
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        
        loginTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showOffersVC(_ sender: Any) {
         performSegue(withIdentifier: "mainToList", sender: self)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginSegue" {
            let destinationVC = segue.destination as? UserProfileViewController
            destinationVC?.name = "Piotrek"
             defaults.set(true, forKey: "logged")
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        defaults.set(true, forKey: "logged")
        let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        self.navigationController?.setViewControllers([userProfileViewController], animated: true)
    }
    
    func showUserProfileVC() {
        let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        self.navigationController?.setViewControllers([userProfileViewController], animated: false)
    }

    //
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = SearchOffersTableViewController()
//        segue.destination(vc)
//    }
    
}



