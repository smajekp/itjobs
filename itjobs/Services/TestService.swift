//
//  TestService.swift
//  itjobs
//
//  Created by Piotrek on 25.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class TestService {

    func getTestId(offerId: Int, userId: Int, completionHandler: @escaping (TestId?, NSError?) -> ()){
        getTestIdRequest(offerId: offerId, userId: userId, completionHandler: completionHandler)
    }
    
    func getTestIdRequest(offerId: Int, userId: Int, completionHandler: @escaping (TestId?, NSError?) -> ()){
        let path: String = "test/" + String(offerId) + "/" + String(userId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<TestIdResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: TestId = baseResponse.result!
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
    
    func getTestQuestions(offerId: Int, completionHandler: @escaping ([Question]?, NSError?) -> ()){
        getTestQuestionsRequest(offerId: offerId, completionHandler: completionHandler)
    }
    
    func getTestQuestionsRequest(offerId: Int, completionHandler: @escaping ([Question]?, NSError?) -> ()){
        let path: String = "test_questions/" + String(offerId)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<TestResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [Question] = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
    
    func addResult(testId : Int, userId: Int, points: Int, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        addResultRequest(testId: testId, userId: userId, points: points, completionHandler: completionHandler)
    }
    
    func addResultRequest(testId: Int, userId: Int, points: Int, completionHandler: @escaping (StatusResponse?, NSError?) -> ()){
        
        let path: String = "test?id_test=" + String(testId) + "&id_user=" + String(userId) + "&points=" + String(points)
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<StatusResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    let addResultResponse = StatusResponse()
                    if baseResponse.status != nil {
                        addResultResponse.status = baseResponse.status
                    }
                    completionHandler(addResultResponse, nil)
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
 
}

