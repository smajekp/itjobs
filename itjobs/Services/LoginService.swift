//
//  LoginService.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class LoginService {
    func login(email: String, password: String, completionHandler: @escaping (LoginResponse?, NSError?) -> ()){
        loginRequest(email: email, password: password, completionHandler: completionHandler)
    }

    func loginRequest(email: String, password: String, completionHandler: @escaping (LoginResponse?, NSError?) -> ()){
        let path: String = "login?email=" + String(email) + "&password=" + String(password)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<LoginResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let loginResponse = LoginResponse()
                    if baseResponse.status != nil {
                        loginResponse.status = baseResponse.status
                    }
                    if baseResponse.token != nil {
                        loginResponse.token = baseResponse.token
                    }
                    if baseResponse.user_id != nil {
                        loginResponse.user_id = baseResponse.user_id
                    }
                    if baseResponse.user_type != nil {
                        loginResponse.user_type = baseResponse.user_type
                    }
                    completionHandler(loginResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func logout(user_id: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        logoutRequest(user_id: user_id, completionHandler: completionHandler)
    }
    
    func logoutRequest(user_id: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        let path: String = "logout?user_id=" + String(user_id)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let logoutResponse = StatusResponse()
                    if baseResponse.status != nil {
                        logoutResponse.status = baseResponse.status
                    }
                    completionHandler(logoutResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
}
