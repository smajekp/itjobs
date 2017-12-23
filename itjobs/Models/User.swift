//
//  User.swift
//  itjobs
//
//  Created by Piotrek on 23.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class User:Mappable {
    var id_user : String?
    var name : String?
    var email : String?
    var password : String?
    var create_date : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id_user <- map["id_user"]
        name <- map["name"]
        email <- map["email"]
        password <- map["password"]
        create_date <- map["create_date"]
    }
    
    
}
