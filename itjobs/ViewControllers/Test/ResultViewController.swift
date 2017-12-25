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
    var statusResponse = StatusResponse()
    var testId = TestId()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "Wynik"
        
        let user_id = defaults.object(forKey: "user_id") as? String
        if let user_id = user_id {
            addResult(testId: Int(testId.id_test!)!, userId: Int(user_id)!, points: result)
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultText.text = "Koniec testu - Twój wynik to:" + String(result) + " punkty. Wkrótce odezwie się do Ciebie Nasz pracownik HR."
    }
    
    func addResult(testId: Int, userId: Int, points: Int) {
        let testService = TestService()
        testService.addResult(testId: testId, userId: userId, points: points,  completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.statusResponse = responseObject
                }
            }
            return
        })
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
