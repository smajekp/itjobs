//
//  ViewController.swift
//  itjobs
//
//  Created by Piotrek on 02.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let offersService = OffersService()
        offersService.getOffer(offerNumber: 171, completionHandler: { responseObject, error in
            if error == nil {
                print(responseObject!)
            }
            return
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

