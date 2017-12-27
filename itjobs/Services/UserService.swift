//
//  UserService.swift
//  itjobs
//
//  Created by Piotrek on 23.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class UserService {
    
    func getCV(userId: Int, completionHandler: @escaping (CV?, NSError?) -> ()){
        getCVRequest(userId: userId, completionHandler: completionHandler)
    }
    
    func getCVRequest(userId: Int, completionHandler: @escaping (CV?, NSError?) -> ()){
        let path: String = "user_cv/" + String(userId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<CVResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse:CV = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func updateCV(userId: Int, cv: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        updateCVRequest(userId: userId, cv: cv, completionHandler: completionHandler)
    }
    
    func updateCVRequest(userId: Int, cv: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        var cvString = cv
        if (cv == "") {
            cvString = "NULL"
        }
        let path: String = "user/" + String(userId) + "/" + cvString
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.put, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let CVStatusResponse = StatusResponse()
                    if baseResponse.status != nil {
                        CVStatusResponse.status = baseResponse.status
                    }
                    completionHandler(CVStatusResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func getUser(userId: Int, completionHandler: @escaping (User?, NSError?) -> ()){
        getUserRequest(userId: userId, completionHandler: completionHandler)
    }
    
    func getUserRequest(userId: Int, completionHandler: @escaping (User?, NSError?) -> ()){
        let path: String = "user/"
        let url = Constants.baseURL + path + String(userId)
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<UserResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: User = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
}
