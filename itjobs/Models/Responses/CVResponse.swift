//
//  CVResponse.swift
//  itjobs
//
//  Created by Piotrek on 24.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class CVResponse:Mappable {
    var status : Bool?
    var result : CV?
    
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
