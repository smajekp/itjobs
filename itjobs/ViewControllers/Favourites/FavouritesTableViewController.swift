//
//  FavouritesTableViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {

    var resultOffers = [Offer]()
    var activityView = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.title = "Ulubione"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        if (!(self.resultOffers.count > 0)) {
            activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityView.center = CGPoint(x: self.view.center.x,y: 150);
            activityView.startAnimating()
            self.view.addSubview(activityView)
        }
        
        getFavouritesOffers(userId: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }
    
    func getFavouritesOffers(userId: Int) {
        let offersService = OffersService()
        offersService.getFavouritesOffers(userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.resultOffers = responseObject
                    self.activityView.removeFromSuperview()
                    
                    self.tableView.reloadData()
                }
            } else {
                self.resultOffers = []
                self.activityView.removeFromSuperview()
                self.tableView.reloadData()
                
                let isLogged = self.defaults.object(forKey: "logged") as? Bool
                if (isLogged)! {
                    let swiftMessage = SwiftMessage()
                    swiftMessage.errorMessage(title: "Niestety!", body: "Brak ofert w ulubionych")
                } else {
                    let swiftMessage = SwiftMessage()
                    swiftMessage.errorMessage(title: "Zaloguj się!", body: "Aby móc dodawać oferty do ulubionych")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteOfferCell", for: indexPath) as! OffersTableViewCell
        
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
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchOfferDetailsViewController") as! SearchOfferDetailsViewController
        secondViewController.offer = offer
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }

}

