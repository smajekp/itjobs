//
//  Company.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class Company:Mappable {
    var id : String?
    var name : String?
    var logo : String?
    var website : String?
    var address : String?
    var employees : String?
    var capital : String?
    var technologies : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        logo <- map["logo"]
        website <- map["website"]
        address <- map["address"]
        employees <- map["employees"]
        capital <- map["capital"]
        technologies <- map["technologies"]
    }
    
    
}
