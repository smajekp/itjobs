//
//  FavouriteOfferDetailsViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class FavouriteOfferDetailsViewController: UIViewController {

    var titleLabelText: String! = ""
    @IBOutlet weak var offerTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offerTitle.text = titleLabelText
        
        // Do any additional setup after loading the view.
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
