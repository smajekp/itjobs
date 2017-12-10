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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutAction(_ sender: Any) {
        defaults.set(false, forKey: "logged")
       // performSegue(withIdentifier: "logoutSegue", sender: self)
        
        let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.setViewControllers([userProfileViewController], animated: false)
        
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "logoutSegue" {
//            let destinationVC = segue.destination as? LoginViewController
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
