//
//  TestCompanyResultsTableViewController.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class TestCompanyResultsTableViewController: UITableViewController {

   
    var resultOffers = [TestCompanyResult]()
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
            getTestCompanyResult(userId: Int(user_id)!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }
    
    func getTestCompanyResult(userId: Int) {
        let testResultService = TestResultsService()
        testResultService.getTestCompanyResult(userId: userId, completionHandler: { responseObject, error in
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
                    swiftMessage.errorMessage(title: "Niestety!", body: "Brak wypełnionych testów dla Twojej firmy")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCompanyResultCell", for: indexPath) as! TestCompanyResultTableViewCell
        
        cell.offerTitle?.text = self.resultOffers[indexPath.row].title
        cell.name?.text = self.resultOffers[indexPath.row].name
        cell.email?.text = self.resultOffers[indexPath.row].email
        cell.points?.text = self.resultOffers[indexPath.row].points! + " punkty z testu rekrutacyjnego"
        
        let imageUrl = URL(string: Constants.baseURLImage + self.resultOffers[indexPath.row].cv!)!
        
        let image = UIImage(named: "placeholder-image")
        cell.cvImage.kf.setImage(with: imageUrl, placeholder: image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let offer: Offer = Offer()
//        offer.id = Int(resultOffers[indexPath.row].id!)
//
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchOfferDetailsViewController") as! SearchOfferDetailsViewController
//        secondViewController.offer = offer
//        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        performSegue(withIdentifier: "userTestDetailsSegue", sender: resultOffers[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userTestDetailsSegue" {
            if (segue.destination is UserTestResultViewController) {
                let detailsController = segue.destination as? UserTestResultViewController
                detailsController?.result = sender as! TestCompanyResult
                
                let backItem = UIBarButtonItem()
                backItem.title = "Powrót"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    

}
