//
//  LoginResponse.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse:Mappable {
    var status : String?
    var token : String?
    var user_id : String?
    var user_type : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        token <- map["token"]
        user_id <- map["user_id"]
        user_type <- map["user_type"]
    }
    
    
}
