//
//  FavouritesService.swift
//  itjobs
//
//  Created by Piotrek on 23.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class FavouritesService {
    
    func isFavouritesAdded(userId: Int, offerId: Int, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        isFavouritesAddedRequest(userId: userId, offerId: offerId, completionHandler: completionHandler)
    }
    
    func isFavouritesAddedRequest(userId: Int, offerId: Int, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        let path: String = "favourite/" + String(userId) + "/" + String(offerId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let favouritesStatusResponse = StatusResponse()
                    if baseResponse.status != nil {
                        favouritesStatusResponse.status = baseResponse.status
                    }
                    completionHandler(favouritesStatusResponse, nil)
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
    
    func addToFavourites(userId : String, offerId: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        addToFavouritesRequest(userId: userId, offerId: offerId, completionHandler: completionHandler)
    }
    
    func addToFavouritesRequest(userId: String, offerId: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        
        let path: String = "favourite?id_user=" + String(userId) + "&id_offer=" + String(offerId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let addToFavouritesResponse = StatusResponse()
                    if baseResponse.status != nil {
                        addToFavouritesResponse.status = baseResponse.status
                    }
                    completionHandler(addToFavouritesResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func deleteFromFavourites(userId : String, offerId: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        deleteFromFavouritesRequest(userId: userId, offerId: offerId, completionHandler: completionHandler)
    }
    
    func deleteFromFavouritesRequest(userId: String, offerId: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        
        let path: String = "favourite/" + String(userId) + "/" + String(offerId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let addToFavouritesResponse = StatusResponse()
                    if baseResponse.status != nil {
                        addToFavouritesResponse.status = baseResponse.status
                    }
                    completionHandler(addToFavouritesResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
}
