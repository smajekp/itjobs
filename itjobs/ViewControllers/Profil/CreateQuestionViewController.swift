//
//  CreateQuestionViewController.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class CreateQuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let offersPicker = UIPickerView()
    var resultOffers = [CompanyPicker]()
    @IBOutlet weak var offersTextField: UITextField!
    var offerIdString = ""
    let defaults = UserDefaults.standard
    var statusResponse = StatusResponse()
    
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    @IBOutlet weak var answer4: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.title = "Dodaj pytanie"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        createPickerWithToolbar(picker: offersPicker, textField: offersTextField)
        
        let user_id = defaults.object(forKey: "user_id") as? String
        if user_id != nil && user_id != "" {
            getOffersPicker(userId: Int(user_id!)!)
        }
        
        self.question.delegate = self
        self.answer1.delegate = self
        self.answer2.delegate = self
        self.answer3.delegate = self
        self.answer4.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPickerWithToolbar(picker: UIPickerView, textField: UITextField) {
        picker.delegate = self
        picker.dataSource = self
        
        picker.backgroundColor = .white
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barTintColor = UIColor(rgb: 0xffffff)
        toolBar.tintColor = UIColor(rgb: 0x000000)
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        var doneButton = UIBarButtonItem()
        var cancelButton = UIBarButtonItem()
        doneButton = UIBarButtonItem(title: "Wybierz", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        cancelButton = UIBarButtonItem(title: "Anuluj", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        let row : Int = offersPicker.selectedRow(inComponent: 0)
        self.offersTextField.text = resultOffers[row].title
        self.offerIdString = resultOffers[row].id!
        
        self.view.endEditing(false)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(false)
    }
    
    func getOffersPicker(userId: Int) {
        let offersService = OffersService()
        offersService.getOffersPicker(userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.resultOffers = responseObject
                    self.offersPicker.reloadAllComponents()
                }
            }
            return
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return resultOffers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return resultOffers[row].title
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBAction func addQuestion(_ sender: Any) {
        if (offerIdString.count > 0 || question.text!.count > 0 || answer1.text!.count > 0 || answer2.text!.count > 0 || answer3.text!.count > 0 || answer4.text!.count > 0) {
            addQuestion(id_offer: offerIdString, question: question.text!, answer1: answer1.text!, answer2: answer2.text!, answer3: answer3.text!, answer4: answer4.text!)
        } else {
            let swiftMessage = SwiftMessage()
            swiftMessage.errorMessage(title: "Błąd!", body: "Wypełnij wszystkie pola")
        }
    }
    
    func addQuestion(id_offer: String, question: String, answer1: String, answer2 : String, answer3: String, answer4: String) {
        let testService = TestService()
        testService.addQuestion(id_offer: id_offer, question: question, answer1: answer1, answer2: answer2, answer3: answer3, answer4: answer4, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.statusResponse = responseObject
                    if (self.statusResponse.status == "Test question added") {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.successMessage(title: "OK!", body: "Dodano pytanie!")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            swiftMessage.hideMessage()
                            self.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.errorMessage(title: "Błąd!", body: "Pytanie nie dodane!")
                    }
                }
            }
            return
        })
    }
    
}
