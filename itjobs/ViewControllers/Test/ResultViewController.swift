//
//  ResultViewController.swift
//  itjobs
//
//  Created by Piotrek on 24.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultText: UILabel!
    var result: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "Wynik"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultText.text = String(result)

    }

    @IBAction func backToOffer(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
