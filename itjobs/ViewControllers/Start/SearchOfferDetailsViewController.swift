//
//  SearchOfferDetailsViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class SearchOfferDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var technologiesElements: UILabel!
    @IBOutlet weak var methodologyElements: UILabel!
    @IBOutlet weak var offerView: UIView!
    var offer: Offer!
    var offerResponse: Offer!
    
    var activityView = UIActivityIndicatorView()
    var customView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Oferta"
        
        self.offerView.isHidden = true
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = CGPoint(x: self.view.center.x,y: 150);
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        if let offerId = offer.id {
            getOffer(offerNumber: offerId)
        }
        
    }
    
    var strings:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.createDateLabel.text = offer.publication_date
        
       
        

    }
    
    func getOffer(offerNumber: Int) {
        let offersService = OffersService()
        offersService.getOffer(offerNumber: offerNumber, completionHandler: { responseObject, error in
            if error == nil {
                //print(responseObject!)
                if let responseObject = responseObject {
                    self.offerResponse = responseObject
                    
                    if let offerTechnologies = self.offerResponse.technologies {
                        var technologiesElementsString = ""
                        for technology in offerTechnologies {
                            technologiesElementsString += "•" + technology + "\n"
                        }
                        self.technologiesElements.text = technologiesElementsString
                    }
                    
                    if let offerMethodologies = self.offerResponse.methodology {
                        var methodologiesElementsString = ""
                        for methodology in offerMethodologies {
                            methodologiesElementsString += "•" + methodology.name! + " - " + String(methodology.isAvailable!) + "\n"
                        }
                        self.methodologyElements.text = methodologiesElementsString
                    }
                    
                    self.titleLabel.text = self.offerResponse.title
                    
                    self.offerView.isHidden = false
                    self.activityView.removeFromSuperview()
                    
//                    self.activityView.removeFromSuperview()
//
//                    self.tableView.reloadData()
                    //self.setupView(resource: responseObject)
                    //self.showLoginVC()
                }
            }
            return
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
