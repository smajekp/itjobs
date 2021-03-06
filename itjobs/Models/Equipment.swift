//
//  Equipment.swift
//  itjobs
//
//  Created by Piotrek on 03.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//
import Foundation
import ObjectMapper
class Equipment:Mappable {
    var name : String?
    var isAvailable : Bool?
    var system : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        isAvailable <- map["isAvailable"]
        system <- map["system"]
    }
    
    
}
