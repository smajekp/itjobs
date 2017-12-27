//
//  TestUserResultsTableViewController.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class TestUserResultsTableViewController: UITableViewController {
    
    var resultOffers = [TestUserResult]()
    var activityView = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.title = "Wypełnione testy"
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
        
        let user_id = defaults.object(forKey: "user_id") as? String
        if let user_id = user_id {
            getTestUserResult(userId: Int(user_id)!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }
    
    func getTestUserResult(userId: Int) {
        let testResultService = TestResultsService()
        testResultService.getTestUserResult(userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.resultOffers = responseObject
                    self.activityView.removeFromSuperview()
                    
                    self.tableView.reloadData()
                } else {
                    self.resultOffers = []
                    self.activityView.removeFromSuperview()
                    self.tableView.reloadData()
                    
                    let swiftMessage = SwiftMessage()
                    swiftMessage.errorMessage(title: "Niestety!", body: "Brak wypełnionych testów")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "testUserResultCell", for: indexPath) as! TestUserResultTableViewCell
        
        cell.offerTitle?.text = self.resultOffers[indexPath.row].title
        cell.companyName?.text = self.resultOffers[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offer: Offer = Offer()
        offer.id = Int(resultOffers[indexPath.row].id!)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchOfferDetailsViewController") as! SearchOfferDetailsViewController
        secondViewController.offer = offer
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }

}
