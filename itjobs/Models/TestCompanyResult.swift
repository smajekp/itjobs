//
//  TestCompanyResult.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class TestCompanyResult:Mappable {
    var name : String?
    var email : String?
    var cv : String?
    var points : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        cv <- map["cv"]
        points <- map["points"]
    }
    
}

