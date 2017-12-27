//
//  TestCompanyResultResponse.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper
class TestCompanyResultResponse:Mappable {
    var status : Bool?
    var result : [TestCompanyResult]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        result <- map["result"]
    }
    
    
}

