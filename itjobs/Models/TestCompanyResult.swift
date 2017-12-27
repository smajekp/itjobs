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
    var title : String?
    var id : String?
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
        title <- map["title"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        cv <- map["cv"]
        points <- map["points"]
    }
    
}

