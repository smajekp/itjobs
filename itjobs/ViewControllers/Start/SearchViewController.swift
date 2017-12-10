//
//  SearchViewController.swift
//  itjobs
//
//  Created by Piotrek on 02.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class SearchViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getOffer(offerNumber: 171)
    }
    
    func getOffer(offerNumber: Int) {
        let offersService = OffersService()
        offersService.getOffer(offerNumber: offerNumber, completionHandler: { responseObject, error in
            if error == nil {
                //print(responseObject!)
                if let responseObject = responseObject {
                    self.result = responseObject
                    self.setupView(resource: responseObject)
                    //self.showLoginVC()
                }
            }
            return
        })
    }
    
    func setupView(resource: Result) {
        self.label.text = resource.city
    }
    
    func showLoginVC() {
        let vc = LoginViewController() //change this to your class name
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

