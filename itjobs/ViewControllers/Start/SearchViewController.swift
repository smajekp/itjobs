//
//  SearchViewController.swift
//  itjobs
//
//  Created by Piotrek on 02.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RangeSeekSlider
import M13Checkbox

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var phraseTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var salaryCheckboxView: UIView!
    @IBOutlet weak var polishLanguageView: UIView!
    @IBOutlet weak var englishLanguageView: UIView!
    
    var salaryCheckbox = M13Checkbox()
    var polishCheckbox = M13Checkbox()
    var englishCheckbox = M13Checkbox()
    
    var result = Offer()
    var resultOffers = [Offer]()
    let defaults = UserDefaults.standard
    var minPriceValue: Int = 1000
    var maxPriceValue: Int = 10000
    
    var cityArray = ["Wszystkie","Katowice", "Gliwice", "Jelenia Góra", "Kraków", "Łódź", "Opole", "Poznań", "Szczecin", "Warszawa", "Wrocław"]
    let cityPicker = UIPickerView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setupCheckboxes()
        
        phraseTextField.placeholderColor(color: UIColor.white)
        phraseTextField.setBottomBorder()
        
        cityTextField.placeholderColor(color: UIColor.white)
        cityTextField.setBottomBorder()
        
        self.phraseTextField.delegate = self
        self.cityTextField.delegate = self
        
        setupRangeSlider()

        createCityPicker()
    }
    
    func createCityPicker() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        cityPicker.backgroundColor = .white
        cityPicker.showsSelectionIndicator = true
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
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
        
        cityTextField.inputView = cityPicker
        cityTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        let row : Int = cityPicker.selectedRow(inComponent: 0)
        self.cityTextField.text = cityArray[row]
        
        self.view.endEditing(false)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray[row]
    }
    
    func setupCheckboxes(){
        salaryCheckbox = M13Checkbox(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        salaryCheckbox.boxLineWidth = 2.0
        salaryCheckbox.checkmarkLineWidth = 2.0
        salaryCheckbox.cornerRadius = 2.0
        salaryCheckbox.secondaryTintColor = UIColor.white
        salaryCheckboxView.addSubview(salaryCheckbox)
        
        polishCheckbox = M13Checkbox(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        polishCheckbox.boxLineWidth = 2.0
        polishCheckbox.checkmarkLineWidth = 2.0
        polishCheckbox.cornerRadius = 2.0
        polishCheckbox.secondaryTintColor = UIColor.white
        polishLanguageView.addSubview(polishCheckbox)
        
        englishCheckbox = M13Checkbox(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        englishCheckbox.boxLineWidth = 2.0
        englishCheckbox.checkmarkLineWidth = 2.0
        englishCheckbox.cornerRadius = 2.0
        englishCheckbox.secondaryTintColor = UIColor.white
        englishLanguageView.addSubview(englishCheckbox)
    }
    
    func polishCheckBoxState() -> String {
        switch polishCheckbox.checkState {
        case .unchecked:
            return ""
        case .checked:
            return "pl"
        case .mixed:
            return ""
        }
    }
    
    func englishCheckBoxState() -> String {
        switch englishCheckbox.checkState {
        case .unchecked:
            return ""
        case .checked:
            return "eng"
        case .mixed:
            return ""
        }
    }

    func salaryCheckBoxState() -> String {
        switch salaryCheckbox.checkState {
        case .unchecked:
            return "0"
        case .checked:
            return "1"
        case .mixed:
            return ""
        }
    }
    
    func setupRangeSlider() {
        rangeSlider.delegate = self
        rangeSlider.numberFormatter.numberStyle = .currency
        rangeSlider.numberFormatter.locale = Locale(identifier: "pl_PL")
        rangeSlider.numberFormatter.maximumFractionDigits = 0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            if (segue.destination is SearchOffersTableViewController) {
                let tableViewController = segue.destination as? SearchOffersTableViewController
                    tableViewController?.titleValue = phraseTextField.text
                    tableViewController?.lowerSalaryValue = String(minPriceValue)
                    tableViewController?.upperSalaryValue = String(maxPriceValue)
                    tableViewController?.haveSalaryValue = salaryCheckBoxState()
                    tableViewController?.languageValue = englishCheckBoxState() + polishCheckBoxState()
                    tableViewController?.cityValue = self.cityTextField.text
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            minPriceValue = Int(minValue)
            maxPriceValue = Int(maxValue)
        }
    }
}

