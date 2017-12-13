//
//  CompaniesService.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import Alamofire

class CommpaniesService {

    func getCompanies(completionHandler: @escaping ([Company]?, NSError?) -> ()){
        getCompaniesRequest(completionHandler: completionHandler)
    }
    
    func getCompaniesRequest(completionHandler: @escaping ([Company]?, NSError?) -> ()){
        let path: String = "companiesNames"
        let url = Constants.baseURL + path
        
        Alamofire.request(url,  method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<CompaniesResponse>) in
            switch response.result {
            case .success:
                if let baseResponse = response.result.value {
                    if baseResponse.result != nil {
                        let resultResponse: [Company] = baseResponse.result!
                        completionHandler(resultResponse, nil)
                    }
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
    }
}
