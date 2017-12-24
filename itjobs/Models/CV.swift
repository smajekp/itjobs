//
//  CV.swift
//  itjobs
//
//  Created by Piotrek on 24.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class CV:Mappable {
    var id_user : String?
    var cv : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id_user <- map["id_user"]
        cv <- map["cv"]
    }
    
    
}
