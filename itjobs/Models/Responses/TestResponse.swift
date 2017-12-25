//
//  TestResponse.swift
//  itjobs
//
//  Created by Piotrek on 25.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class TestResponse:Mappable {
    var status : Bool?
    var result : [Question]?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        result <- map["result"]
    }
    
    
}
