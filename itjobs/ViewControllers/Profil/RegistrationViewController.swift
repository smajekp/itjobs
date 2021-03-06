//
//  RegistrationViewController.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var userType: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var companyStackView: UIStackView!
    
    var userTypeArray = ["Użytkownik", "Pracownik HR"]
    let userTypePicker = UIPickerView()
    
    var resultCompanies = [Company]()
    var statusResponse = StatusResponse()
    let companiesPicker = UIPickerView()
    
    var userTypeString: String = ""
    var idCompanyString: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Rejestracja"
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Raleway-Regular", size: 15.0)!], for: .normal)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.companyStackView.isHidden = true
        
        getCompanies()
        
        createPickerWithToolbar(picker: userTypePicker, textField: userType, tag: 1)
        createPickerWithToolbar(picker: companiesPicker, textField: companyName, tag: 2)
        
        setPlaceholdersColorsAndBorderBottom()
        
        self.emailTextField.delegate = self
        self.nameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.retypePasswordTextField.delegate = self
    
    }
    
    func createPickerWithToolbar(picker: UIPickerView, textField: UITextField, tag: Int ) {
        picker.delegate = self
        picker.dataSource = self
        
        picker.backgroundColor = .white
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        picker.tag = tag
        
        let toolBar = UIToolbar()
        toolBar.barTintColor = UIColor(rgb: 0xffffff)
        toolBar.tintColor = UIColor(rgb: 0x000000)
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        var doneButton = UIBarButtonItem()
        var cancelButton = UIBarButtonItem()
        if (tag == 1) {
            doneButton = UIBarButtonItem(title: "Wybierz", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneUserPicker))
            cancelButton = UIBarButtonItem(title: "Anuluj", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        } else {
            doneButton = UIBarButtonItem(title: "Wybierz", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneCompanyPicker))
            cancelButton = UIBarButtonItem(title: "Anuluj", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        }
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneUserPicker() {
        let row : Int = userTypePicker.selectedRow(inComponent: 0)
        self.userType.text = userTypeArray[row]
        self.userTypeString = userTypeArray[row]
        self.companyStackView.isHidden = row == 0
        
        self.view.endEditing(false)
    }
    
    @objc func doneCompanyPicker() {
        let row : Int = companiesPicker.selectedRow(inComponent: 0)
        self.companyName.text = resultCompanies[row].name
        self.idCompanyString = resultCompanies[row].id!
        
        self.view.endEditing(false)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(false)
    }
    
    func setPlaceholdersColorsAndBorderBottom() {
        emailTextField.placeholderColor(color: UIColor.white)
        emailTextField.setBottomBorder()
        
        nameTextField.placeholderColor(color: UIColor.white)
        nameTextField.setBottomBorder()
        
        passwordTextField.placeholderColor(color: UIColor.white)
        passwordTextField.setBottomBorder()
        
        retypePasswordTextField.placeholderColor(color: UIColor.white)
        retypePasswordTextField.setBottomBorder()
    }
    
    func getCompanies() {
        let companiesService = CommpaniesService()
        companiesService.getCompanies(completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.resultCompanies = responseObject
                    self.companiesPicker.reloadAllComponents()
                }
            }
            return
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return userTypeArray.count
        }else{
            return resultCompanies.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return userTypeArray[row]
        }else{
            return resultCompanies[row].name
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //login(email: loginTextField.text!, password: passwordTextField.text!)
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        if (emailTextField.text!.count > 0) {
            if (isValidEmail(testStr: emailTextField.text!)) {
                if (nameTextField.text!.count > 0) {
                    if (passwordTextField.text!.count > 0 || retypePasswordTextField.text!.count > 0) {
                        if (passwordTextField.text! == retypePasswordTextField.text!) {
                            if (userTypeString.count > 0) {
                                
                                if(userTypeString == "Pracownik HR" || userTypeString == "employees") {
                                    if(idCompanyString.count > 0) {
                                        userTypeString = "employees"
                                        createUser(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, type : userTypeString, id_company: idCompanyString)
                                    } else {
                                        let swiftMessage = SwiftMessage()
                                        swiftMessage.errorMessage(title: "Błąd!", body: "Wybierz firmę")
                                    }
                                } else {
                                    userTypeString = "user"
                                    createUser(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, type : userTypeString, id_company: idCompanyString)
                                }
                            } else {
                                let swiftMessage = SwiftMessage()
                                swiftMessage.errorMessage(title: "Błąd!", body: "Wybierz typ użytkownika")
                            }
                        } else {
                            let swiftMessage = SwiftMessage()
                            swiftMessage.errorMessage(title: "Błąd!", body: "Hasła się różnią")
                        }
                    } else {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.errorMessage(title: "Błąd!", body: "Podaj hasło")
                    }
                } else {
                    let swiftMessage = SwiftMessage()
                    swiftMessage.errorMessage(title: "Błąd!", body: "Podaj imię i nazwisko")
                }
            } else {
                let swiftMessage = SwiftMessage()
                swiftMessage.errorMessage(title: "Błąd!", body: "Podaj poprawny email")
            }
        } else {
            let swiftMessage = SwiftMessage()
            swiftMessage.errorMessage(title: "Błąd!", body: "Podaj email")
        }
    }
    
    func createUser(name: String, email: String, password: String, type : String, id_company: String) {
        let registerService = RegisterService()
        registerService.registerUser(name: name, email: email, password: password, type: type, id_company: id_company,
                                     completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.statusResponse = responseObject
                    if (self.statusResponse.status == "User Created") {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.successMessage(title: "Rejestracja OK!", body: "Od teraz możesz się logować!")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            swiftMessage.hideMessage()
                            self.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.errorMessage(title: "Błąd!", body: "Użytkownik istnieje")
                    }
                }
            }
            return
        })
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
