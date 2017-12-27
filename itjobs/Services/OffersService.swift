//
//  OffersService.swift
//  itjobs
//
//  Created by Piotrek on 03.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class OffersService {
    func getOffer(offerNumber: Int, completionHandler: @escaping (Offer?, NSError?) -> ()){
        getOfferRequest(offerNumber: offerNumber, completionHandler: completionHandler)
    }
    
    func getOfferRequest(offerNumber: Int, completionHandler: @escaping (Offer?, NSError?) -> ()){
        let path: String = "offer/"
        let url = Constants.baseURL + path + String(offerNumber)
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<OfferResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: Offer = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func getOffers(pageNumber: Int, completionHandler: @escaping ([Offer]?, NSError?) -> ()){
        getOffersRequest(pageNumber: pageNumber, completionHandler: completionHandler)
    }
    
    func getOffersRequest(pageNumber: Int, completionHandler: @escaping ([Offer]?, NSError?) -> ()){
        let path: String = "offers?page=" + String(pageNumber) + "&limit=200"
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<OffersResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [Offer] = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func findOffers(title: String, lowerSalary: String, upperSalary: String, haveSalary: String, language: String, city: String, completionHandler: @escaping ([Offer]?, NSError?) -> ()){
        findOffersRequest(title: title, lowerSalary: lowerSalary, upperSalary: upperSalary, haveSalary: haveSalary, language: language, city: city, completionHandler: completionHandler)
    }
    
    func findOffersRequest(title: String, lowerSalary: String, upperSalary: String, haveSalary: String, language: String, city: String, completionHandler: @escaping ([Offer]?, NSError?) -> ()){
        
        var titleString = ""
        if (title.count > 0) {
             titleString = "&title=" + title
        }
        
        var languageString = ""
        if (language != "engpl") {
            languageString = "&language=" + String(language)
            if (language == "") {
                languageString = ""
            }
        }
        
        var cityString = city
        if (language == "eng") {
            if (city == "Warszawa") {
                cityString = "Warsaw"
            }
        }
        
        if (city == "Kraków") {
            cityString = "Krakow"
        }
        
        if (city == "Łódź") {
            cityString = "Lodz"
        }
        
        if (city == "Wrocław") {
            cityString = "Wroclaw"
        }
        
        if (city == "Jelenia Góra") {
            cityString = "Jelenia Gora"
        }
        
        if (city == "Poznań") {
            cityString = "Poznan"
        }
        
        if (city == "Wszystkie") {
            cityString = ""
        }
        
        var salary = ""
        if (haveSalary == "1") {
            salary = "&lower_salary=" + String(lowerSalary) + "&upper_salary=" + String(upperSalary)
        }
        
        var haveSalaryString = ""
        if (salary == "" && titleString == "") {
            haveSalaryString = "have_salary="
        } else {
            haveSalaryString = "&have_salary="
        }
        
        let path: String = "offer?" + String(titleString) + salary + haveSalaryString + String(haveSalary) + languageString + "&city=" + String(cityString)
        
        let pathString: String = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = Constants.baseURL + pathString
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<OffersResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [Offer] = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    } else {
                        completionHandler(nil, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func getOffersPicker(userId: Int, completionHandler: @escaping ([CompanyPicker]?, NSError?) -> ()){
        getOffersPickerRequest(userId: userId, completionHandler: completionHandler)
    }
    
    func getOffersPickerRequest(userId: Int, completionHandler: @escaping ([CompanyPicker]?, NSError?) -> ()){
        let path: String = "offers_test/" + String(userId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<CompanyPickerResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [CompanyPicker] = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }

}
