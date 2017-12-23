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
        
        var languageString = ""
        if (language != "engpl") {
            languageString = "&language=" + String(language)
        }
        
        var cityString = city
        if (language == "eng") {
            if (city == "Warszawa") {
                cityString = "Warsaw"
            }
        }
        if (city == "Wszystkie") {
            cityString = ""
        }
        
        var salary = ""
        if (haveSalary == "1") {
            salary = "&lower_salary=" + String(lowerSalary) + "&upper_salary=" + String(upperSalary)
        }
        
        let path: String = "offer?title=" + String(title) + salary + "&have_salary=" + String(haveSalary) + languageString + "&city=" + String(cityString)
        
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
    
    func getFavouritesOffers(userId: Int, completionHandler: @escaping ([Offer]?, NSError?) -> ()){
        getFavouritesOffersRequest(userId: userId, completionHandler: completionHandler)
    }
    
    func getFavouritesOffersRequest(userId: Int, completionHandler: @escaping ([Offer]?, NSError?) -> ()){
        let path: String = "favourite/" + String(userId)
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

}
