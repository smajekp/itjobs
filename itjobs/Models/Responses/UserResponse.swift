//
//  UserResponse.swift
//  itjobs
//
//  Created by Piotrek on 23.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse:Mappable {
    var status : Bool?
    var result : User?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        result <- map["result"]
    }
    
    
}
