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
