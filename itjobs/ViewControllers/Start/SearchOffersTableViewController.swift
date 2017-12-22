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
import Kingfisher

class SearchOffersTableViewController: UITableViewController {

    var resultOffers = [Offer]()
    var activityView = UIActivityIndicatorView()
    
    var titleValue : String?
    var lowerSalaryValue : String?
    var upperSalaryValue : String?
    var haveSalaryValue : String?
    var languageValue : String?
    var cityValue : String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.title = "Wyniki"
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Raleway-Regular", size: 15.0)!], for: .normal)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        
        if (!(self.resultOffers.count > 0)) {
            activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityView.center = CGPoint(x: self.view.center.x,y: 150);
            activityView.startAnimating()
            self.view.addSubview(activityView)
        }
        
        getOffers(title: titleValue!, lowerSalary: lowerSalaryValue!, upperSalary: upperSalaryValue!, haveSalary: haveSalaryValue!, language: languageValue!, city: cityValue!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getOffers(title: String, lowerSalary: String, upperSalary: String, haveSalary: String, language: String, city: String) {
        let offersService = OffersService()
        offersService.findOffers(title: title, lowerSalary: lowerSalary, upperSalary: upperSalary, haveSalary: haveSalary, language: language, city: city, completionHandler: { responseObject, error in
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.resultOffers.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchOfferCell", for: indexPath) as! OffersTableViewCell
        
        cell.offerTitle?.text = self.resultOffers[indexPath.row].title
        
        let lowerSalaryValueCell: Int = self.resultOffers[indexPath.row].lower_salary!
        let upperSalaryValueCell: Int = self.resultOffers[indexPath.row].upper_salary!
        
        var subtitleValue: String = ""
        if (lowerSalaryValueCell >= 0 && upperSalaryValueCell >= 0) {
            subtitleValue = String(lowerSalaryValueCell) + "zł - " + String(upperSalaryValueCell) + "zł - "
        }
        subtitleValue += self.resultOffers[indexPath.row].city!
        
        cell.offerSubtitle?.text = subtitleValue
        
        let imageUrl = URL(string: self.resultOffers[indexPath.row].logo!)!
        
        let image = UIImage(named: "placeholder-image")
        cell.offerImage.kf.setImage(with: imageUrl, placeholder: image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let offer: Offer = resultOffers[indexPath.row]
       performSegue(withIdentifier: "searchOfferDetailsSegue", sender: offer)
    }
    
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
