//
//  Methodology.swift
//  itjobs
//
//  Created by Piotrek on 03.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import ObjectMapper
import Foundation
class Methodology: Mappable{
    var name : String?
    var isAvailable : Bool?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        isAvailable <- map["isAvailable"]
    }
    
    
}
