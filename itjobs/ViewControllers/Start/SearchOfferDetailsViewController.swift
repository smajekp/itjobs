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
    
    var offer: Offer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.titleLabel.text = offer.title
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Powrót"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.title = "Oferta"
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
