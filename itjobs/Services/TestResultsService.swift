//
//  TestResultsService.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class TestResultsService {

    func getTestUserResult(userId: Int, completionHandler: @escaping ([TestUserResult]?, NSError?) -> ()){
        getTestUserResultRequest(userId: userId, completionHandler: completionHandler)
    }

    func getTestUserResultRequest(userId: Int, completionHandler: @escaping ([TestUserResult]?, NSError?) -> ()){
        let path: String = "test_results/" + String(userId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<TestUserResultResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [TestUserResult] = baseResponse.result!
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
    
    func getTestCompanyResult(userId: Int, completionHandler: @escaping ([TestCompanyResult]?, NSError?) -> ()){
        getTestCompanyResultRequest(userId: userId, completionHandler: completionHandler)
    }
    
    func getTestCompanyResultRequest(userId: Int, completionHandler: @escaping ([TestCompanyResult]?, NSError?) -> ()){
        let path: String = "test_company_results/" + String(userId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<TestCompanyResultResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [TestCompanyResult] = baseResponse.result!
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

}
