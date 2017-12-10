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
        let path: String = "offers?page=" + String(pageNumber) + "&limit=10"
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
