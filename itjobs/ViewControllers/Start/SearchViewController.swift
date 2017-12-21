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
    @IBOutlet weak var phraseTextField: UITextField!
    
    var result = Offer()
    var resultOffers = [Offer]()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phraseTextField.placeholderColor(color: UIColor.white)
        phraseTextField.setBottomBorder()
        
        self.defaults.set(false, forKey: "logged")
        self.defaults.set("", forKey: "user_id")
     
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
    
    func setupView(resource: Offer) {
        self.label.text = resource.city
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            if (segue.destination is SearchOffersTableViewController) {
                let tableViewController = segue.destination as? SearchOffersTableViewController
                    tableViewController?.titleValue = phraseTextField.text
                    tableViewController?.lowerSalaryValue = "0"
                    tableViewController?.upperSalaryValue = "10000"
                    tableViewController?.haveSalaryValue = "1"
                    tableViewController?.languageValue = ""
                    tableViewController?.cityValue = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

