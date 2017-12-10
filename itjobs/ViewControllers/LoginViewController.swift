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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholdersForTextFields()
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
        if segue.identifier == "mainToList" {
            let destinationVC = segue.destination as? OffersViewController
        }
    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = OffersViewController()
//        segue.destination(vc)
//    }
    
}



