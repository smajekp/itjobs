//
//  RegisterService.swift
//  itjobs
//
//  Created by Piotrek on 20.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class RegisterService {
    
    func registerUser(name: String, email: String, password: String, type : String, id_company: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        registerUserRequest(name: name, email: email, password: password, type: type, id_company: id_company, completionHandler: completionHandler)
    }
    
    func registerUserRequest(name: String, email: String, password: String, type : String, id_company: String, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        
        var path: String = "user?name=" + String(name) + "&email=" + String(email) + "&password=" + String(password) + "&type=" + String(type)
    
        if (type == "employees") {
            path =  path + "&id_company=" + String(id_company)
        }
        let pathString: String = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = Constants.baseURL + pathString
        
        Alamofire.request(url,  method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let registerUserResponse = StatusResponse()
                    if baseResponse.status != nil {
                        registerUserResponse.status = baseResponse.status
                    }
                    completionHandler(registerUserResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
}
