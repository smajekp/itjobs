//
//  TestViewController.swift
//  itjobs
//
//  Created by Piotrek on 24.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var resultQuestions = [Question]()
    var offer = Offer()
    var testId = TestId()
    
    var questions = [String]()
    var answers = [[String]]()
    
    //Variables
    var currentQuestion = 0
    var rightAnswerPlacement:UInt32 = 0
    var points = 0;
    
    //Label
    @IBOutlet weak var lbl: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Test"
        
        if let offerId = offer.id {
           getTestQuestions(offerId: offerId)
        }
        
    }
    
    //Button
    @IBAction func action(_ sender: AnyObject) {
        if (sender.tag == Int(rightAnswerPlacement)) {
            print ("RIGHT!")
            points += 1
        }
        else {
            print ("WRONG!!!!!!")
        }
        
        if (currentQuestion != questions.count) {
            newQuestion()
        }
        else {
            performSegue(withIdentifier: "showScore", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newQuestion()
    }
    
    func newQuestion() {
        lbl.text = questions[currentQuestion]
        
        rightAnswerPlacement = arc4random_uniform(3)+1

        var button:UIButton = UIButton()
        var x = 1

        for i in 1...4 {
            button = view.viewWithTag(i) as! UIButton
            
            if (i == Int(rightAnswerPlacement)) {
                button.setTitle(answers[currentQuestion][0], for: .normal)
            }
            else  {
                button.setTitle(answers[currentQuestion][x], for: .normal)
                x = 2
            }
        }
        currentQuestion += 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScore" {
            if (segue.destination is ResultViewController) {
                let resultVC = segue.destination as? ResultViewController
                resultVC?.result = points
                resultVC?.testId = testId
            }
        }
    }
    
    func getTestQuestions(offerId: Int) {
        let testService = TestService()
        testService.getTestQuestions(offerId: offerId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.resultQuestions = responseObject
                    
                    for questionResult in self.resultQuestions {
                        self.questions.append(questionResult.question!)
                        self.answers += [[questionResult.answer1!, questionResult.answer2!, questionResult.answer3!, questionResult.answer4!]]
                    }

                }
            }
            return
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
