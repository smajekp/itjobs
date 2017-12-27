//
//  UserTestResultViewController.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class UserTestResultViewController: UIViewController {
    
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var result = TestCompanyResult()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.title = "Wynik użytkownika"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        self.offerTitle.text = result.title
        self.name.text = result.name
        self.email.text = result.email
        self.points.text = result.points
        
        let imageUrl = URL(string: Constants.baseURLImage + result.cv!)
        let image = UIImage(named: "placeholder-image")
        self.image.kf.setImage(with: imageUrl, placeholder: image)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
