//
//  OffersViewController.swift
//  itjobs
//
//  Created by Piotrek on 09.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class OffersViewController: UITableViewController{
    
    let animals = ["Panda", "Lion", "Elefant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (animals.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OffersTableViewCell
        
        //cell.myImage.image = UIImage(named: (animals[indexPath.row] + ".jpg"))
        cell.offerTitle?.text = animals[indexPath.row]
//        cell.offerSubtitle?.text = animals[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var titleLabel: String = animals[indexPath.row]
       performSegue(withIdentifier: "detailsSegue", sender: titleLabel)
    }
    
    //  Converted to Swift 4 with Swiftify v1.0.6536 - https://objectivec2swift.com/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            if (segue.destination is OfferDetailsViewController) {
                let detailsController = segue.destination as? OfferDetailsViewController
                if (sender is String) {
                    detailsController?.titleLabelText = sender as! String
                }
            }
        }
    }


}
