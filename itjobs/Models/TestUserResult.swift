//
//  TestUserResult.swift
//  itjobs
//
//  Created by Piotrek on 27.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class TestUserResult:Mappable {
    var id : String?
    var title : String?
    var name : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        name <- map["name"]
    }
   
}
