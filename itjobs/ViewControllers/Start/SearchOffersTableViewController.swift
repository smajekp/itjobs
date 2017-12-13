//
//  SearchOffersTableViewController.swift
//  itjobs
//
//  Created by Piotrek on 09.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class SearchOffersTableViewController: UITableViewController{
    
    let animals = ["Panda", "Lion", "Elefant"]
    var resultOffers = [Offer]()
    var activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = CGPoint(x: self.view.center.x,y: 150);
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        getOffers(pageNumber: 1)
    }
    
    func getOffers(pageNumber: Int) {
        let offersService = OffersService()
        offersService.getOffers(pageNumber: pageNumber, completionHandler: { responseObject, error in
            if error == nil {
                //print(responseObject!)
                if let responseObject = responseObject {
                    self.resultOffers = responseObject
                    self.activityView.removeFromSuperview()
                    
                    self.tableView.reloadData()
                    //self.setupView(resource: responseObject)
                    //self.showLoginVC()
                }
            }
            return
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.resultOffers.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchOfferCell", for: indexPath) as! OffersTableViewCell
        
        //cell.myImage.image = UIImage(named: (animals[indexPath.row] + ".jpg"))
        cell.offerTitle?.text = self.resultOffers[indexPath.row].title
//        cell.offerSubtitle?.text = animals[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let offer: Offer = resultOffers[indexPath.row]
       performSegue(withIdentifier: "searchOfferDetailsSegue", sender: offer)
    }
    
    //  Converted to Swift 4 with Swiftify v1.0.6536 - https://objectivec2swift.com/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchOfferDetailsSegue" {
            if (segue.destination is SearchOfferDetailsViewController) {
                let detailsController = segue.destination as? SearchOfferDetailsViewController
                if (sender is Offer) {
                    detailsController?.offer = sender as! Offer
                }
            }
        }
    }


}
