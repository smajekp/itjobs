//
//  SearchOfferDetailsViewController.swift
//  itjobs
//
//  Created by Piotrek on 10.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import UIKit

class SearchOfferDetailsViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataStackView: UIStackView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryStackView: UIStackView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityStackView: UIStackView!
    @IBOutlet weak var workModeLabel: UILabel!
    @IBOutlet weak var workModeStackView: UIStackView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyNameStackView: UIStackView!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var companyAddressStackView: UIStackView!
    @IBOutlet weak var employeesNumber: UILabel!
    @IBOutlet weak var companyEmployeesStackView: UIStackView!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerDescriptionStackView: UIStackView!
    @IBOutlet weak var requirementsStackView: UIStackView!
    @IBOutlet weak var requirementsLabel: UILabel!
    @IBOutlet weak var technologiesElements: UILabel!
    @IBOutlet weak var technologiesStackView: UIStackView!
    @IBOutlet weak var languagesElements: UILabel!
    @IBOutlet weak var languagesStackView: UIStackView!
    @IBOutlet weak var methodologyElements: UILabel!
    @IBOutlet weak var methodologyStackView: UIStackView!
    @IBOutlet weak var equipmentElements: UILabel!
    @IBOutlet weak var equipmentStackView: UIStackView!
    @IBOutlet weak var bonusesElements: UILabel!
    @IBOutlet weak var bonusesStackView: UIStackView!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var addToFavourites: UIButton!
    @IBOutlet weak var deleteFromFavourites: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
    var offer: Offer!
    var offerResponse: Offer!
    var testId: TestId!
    var statusResponse = StatusResponse()
    var isAdded: Bool = false
    
    var activityView = UIActivityIndicatorView()
    var customView = UIView()
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Oferta"
        
        self.offerView.isHidden = true
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = CGPoint(x: self.view.center.x,y: 150);
        activityView.startAnimating()
        self.view.addSubview(activityView)

        let isLogged = defaults.object(forKey: "logged") as? Bool
        if let isLogged = isLogged {
            if (!isLogged) {
                self.addToFavourites.isHidden = true
                self.deleteFromFavourites.isHidden = true
            } else {
                self.addToFavourites.isHidden = false
                self.deleteFromFavourites.isHidden = false
            }
        }
        
        let user_type = defaults.object(forKey: "user_type") as? String
        if user_type != nil && user_type != "" {
            if (user_type == "user") {
                testButton.isHidden = false
            } else {
                testButton.isHidden = true
            }
        } else {
            testButton.isHidden = true
        }
        
        if let offerId = offer.id {
            getOffer(offerNumber: offerId)
        }
        
        if let offerId = offer.id {
            let user_id = defaults.object(forKey: "user_id") as? String
            if user_id != nil && user_id != "" {
                getTestId(offerId: offerId, userId: Int(user_id!)!)
            }
            
        }

        let user_id = defaults.object(forKey: "user_id") as? String
        if user_id != nil && user_id != "" {
            if let offerId = offer.id {
                isFavouritesAdded(userId: user_id!, offerId: String(offerId))
            }
        }
 
    }
    
    var strings:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func addToFavourites(_ sender: Any) {
        let user_id = defaults.object(forKey: "user_id") as? String
        if user_id != nil && user_id != "" {
            if let offerId = offer.id {
                addOfferToFavourites(userId: user_id!, offerId: String(offerId))
            }
        }
    }
    @IBAction func deleteFromFavouritesAction(_ sender: Any) {
        let user_id = defaults.object(forKey: "user_id") as? String
        if user_id != nil && user_id != "" {
            if let offerId = offer.id {
                deleteOfferFromFavourites(userId: user_id!, offerId: String(offerId))
            }
        }
    }
    
    func isFavouritesAdded(userId: String, offerId: String) {
        let favouritesService = FavouritesService()
        favouritesService.isFavouritesAdded(userId: Int(userId)!, offerId: Int(offerId)!, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.statusResponse = responseObject
                    if (self.statusResponse.status == "Favourite found") {
                        self.addToFavourites.isHidden = true
                        self.deleteFromFavourites.isHidden = false
                        self.isAdded = true
                    } else {
                        self.isAdded = false
                        self.addToFavourites.isHidden = false
                        self.deleteFromFavourites.isHidden = true
                    }
                    
                    self.offerView.isHidden = false
                    self.activityView.removeFromSuperview()
                    
                }
            }
            return
        })
    }
    
    func addOfferToFavourites(userId: String, offerId: String) {
        let favouritesService = FavouritesService()
        favouritesService.addToFavourites(userId: userId, offerId: offerId, completionHandler: { responseObject, error in
        if error == nil {
            if let responseObject = responseObject {
                self.statusResponse = responseObject
                if (self.statusResponse.status == "Favourite added") {
                    self.isAdded = true
                    self.addToFavourites.isHidden = true
                    self.deleteFromFavourites.isHidden = false
                    
                    let swiftMessage = SwiftMessage()
                    swiftMessage.successMessage(title: "OK!", body: "Dodano do ulubionych!")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                        swiftMessage.hideMessage()
                    })
                }
            }
        }
        return
        })
    }
    
    func deleteOfferFromFavourites(userId: String, offerId: String) {
        let favouritesService = FavouritesService()
        favouritesService.deleteFromFavourites(userId: userId, offerId: offerId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.statusResponse = responseObject
                    if (self.statusResponse.status == "Favourite deleted") {
                        let swiftMessage = SwiftMessage()
                        swiftMessage.successMessage(title: "OK!", body: "Usunięto z ulubionych!")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            swiftMessage.hideMessage()
                        })
                        
                        self.addToFavourites.isHidden = false
                        self.deleteFromFavourites.isHidden = true
                        self.isAdded = false
                    }
                }
            }
            return
        })
    }
    
    func getTestId(offerId: Int, userId: Int) {
        let testService = TestService()
        testService.getTestId(offerId: offerId, userId: userId, completionHandler: { responseObject, error in
            if error == nil {
                if let responseObject = responseObject {
                    self.testId = responseObject
                    self.testButton.isHidden = false
                } else {
                    self.testButton.isHidden = true
                }
            } else {
                 self.testButton.isHidden = true
            }
        })
    }
    
    func getOffer(offerNumber: Int) {
        let offersService = OffersService()
        offersService.getOffer(offerNumber: offerNumber, completionHandler: { responseObject, error in
            if error == nil {
                //print(responseObject!)
                if let responseObject = responseObject {
                    self.offerResponse = responseObject
                    
                    if (self.offerResponse.logo != nil) {
                        let imageUrl = URL(string: self.offerResponse.logo!)!
                        let image = UIImage(named: "placeholder-image")
                        self.logo.kf.setImage(with: imageUrl, placeholder: image)
                    } else {
                        self.logo.removeFromSuperview()
                    }
                    
                    if (self.offerResponse.title != nil) {
                        self.titleLabel.text = self.offerResponse.title
                    } else {
                        if (self.titleStackView != nil) {
                            self.titleStackView.removeFromSuperview()
                        }
                    }
                    
                    if (self.offerResponse.publication_date != nil) {
                        self.dataLabel.text = self.offerResponse.publication_date
                    } else {
                        if (self.dataStackView != nil) {
                            self.dataStackView.removeFromSuperview()
                        }
                    }
                        
                    if (self.offerResponse.upper_salary! > 0) {
                            self.salaryLabel.text = String(self.offerResponse.lower_salary!) + "zł - " + String(self.offerResponse.upper_salary!) + "zł"
                    } else {
                        if (self.salaryStackView != nil) {
                            self.salaryStackView.removeFromSuperview()
                        }
                    }
                        
                    if (self.offerResponse.city != nil) {
                        self.cityLabel.text = self.offerResponse.city
                    } else {
                        if (self.cityStackView != nil) {
                            self.cityStackView.removeFromSuperview()
                        }
                    }
                    
                    if let offerWorkMode = self.offerResponse.work_mode {
                        var workModeElementsString = ""
                        for workMode in offerWorkMode {
                            workModeElementsString += workMode + " "
                        }
                        self.workModeLabel.text = workModeElementsString
                    } else {
                        if (self.workModeStackView != nil) {
                            self.workModeStackView.removeFromSuperview()
                        }
                    }
                    
                    if (self.offerResponse.name != nil) {
                        self.companyName.text = self.offerResponse.name
                    } else {
                        if (self.companyNameStackView != nil) {
                            self.companyNameStackView.removeFromSuperview()
                        }
                    }
                    
                    if (self.offerResponse.address != nil) {
                        self.companyAddress.text = self.offerResponse.address
                    } else {
                        if (self.companyAddressStackView != nil) {
                            self.companyAddressStackView.removeFromSuperview()
                        }
                    }
                    
                    if (self.offerResponse.employees != nil) {
                        self.employeesNumber.text = self.offerResponse.employees
                    } else {
                        if (self.companyEmployeesStackView != nil) {
                            self.companyEmployeesStackView.removeFromSuperview()
                        }
                    }
                    
                    if (self.offerResponse.city != nil) {
                        let description = self.offerResponse.description!.folding(options: .diacriticInsensitive, locale: .current)
                        let swiftyString = description.replacingOccurrences(of: "ł", with: "l")
                        self.offerDescriptionLabel.text = swiftyString.htmlToString
                    } else {
                        if (self.offerDescriptionStackView != nil) {
                            self.offerDescriptionStackView.removeFromSuperview()
                        }
                    }
                    
                    if let offerRequirements = self.offerResponse.requirements {
                        var offerRequirementsElementsString = ""
                        for requirements in offerRequirements {
                            offerRequirementsElementsString += "•" + requirements + "\n"
                        }
                        self.requirementsLabel.text = offerRequirementsElementsString
                    } else {
                        if (self.requirementsStackView != nil) {
                            self.requirementsStackView.removeFromSuperview()
                        }
                    }
                    
                    if let offerLanguages = self.offerResponse.languages {
                        var offerLanguagesElementsString = ""
                        for language in offerLanguages {
                            offerLanguagesElementsString += "•" + language + "\n"
                        }
                        self.languagesElements.text = offerLanguagesElementsString
                    } else {
                        if (self.languagesStackView != nil) {
                            self.languagesStackView.removeFromSuperview()
                        }
                    }
                    
                    if let offerEquipments = self.offerResponse.equipment {
                        var equipmentsElementsString = ""
                        for equipment in offerEquipments {
                            
                            var isAvailableString = ""
                            if (equipment.isAvailable != nil) {
                                if (String(equipment.isAvailable!) == "true") {
                                    isAvailableString = "✅"
                                } else {
                                    isAvailableString = "❌"
                                }
                            }
                            
                            var systemString = ""
                            if (equipment.system != nil) {
                                systemString = equipment.system!
                            }
                            
                            equipmentsElementsString += "•" + equipment.name! + " - " + isAvailableString + systemString + "\n"
                        }
                        self.equipmentElements.text = equipmentsElementsString
                    } else {
                        if (self.equipmentStackView != nil) {
                            self.equipmentStackView.removeFromSuperview()
                        }
                    }
                    
                    if let offerBonuses = self.offerResponse.bonuses {
                        var bonusesElementsString = ""
                        for bonus in offerBonuses {
                            
                            var isAvailableString = ""
                            if (String(bonus.isAvailable!) == "true") {
                                isAvailableString = "✅"
                            } else {
                                isAvailableString = "❌"
                            }
                            
                            bonusesElementsString += "•" + bonus.name! + " - " + isAvailableString + "\n"
                        }
                        self.bonusesElements.text = bonusesElementsString
                    } else {
                        if (self.bonusesStackView != nil) {
                            self.bonusesStackView.removeFromSuperview()
                        }
                    }
             
                    if let offerTechnologies = self.offerResponse.technologies {
                        var technologiesElementsString = ""
                        for technology in offerTechnologies {
                            technologiesElementsString += "•" + technology + "\n"
                        }
                        self.technologiesElements.text = technologiesElementsString
                    } else {
                        if (self.technologiesStackView != nil) {
                            self.technologiesStackView.removeFromSuperview()
                        }
                    }
                    
                    if let offerMethodologies = self.offerResponse.methodology {
                        var methodologiesElementsString = ""
                        for methodology in offerMethodologies {
                            
                            var isAvailableString = ""
                            if (String(methodology.isAvailable!) == "true") {
                                isAvailableString = "✅"
                            } else {
                                isAvailableString = "❌"
                            }
                            
                            methodologiesElementsString += "•" + methodology.name! + " - " + isAvailableString + "\n"
                        }
                        self.methodologyElements.text = methodologiesElementsString
                    } else {
                        if (self.methodologyStackView != nil) {
                            self.methodologyStackView.removeFromSuperview()
                        }
                    }
                    
                    self.offerView.isHidden = false
                    self.activityView.removeFromSuperview()
                    

                }
            }
            return
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTest" {
            if (segue.destination is TestViewController) {
                let detailsController = segue.destination as? TestViewController
                    detailsController?.offer = self.offer
                    detailsController?.testId = self.testId
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
