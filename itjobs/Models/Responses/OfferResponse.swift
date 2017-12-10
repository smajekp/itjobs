//
//  OfferResponse.swift
//  itjobs
//
//  Created by Piotrek on 03.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper
class OfferResponse:Mappable {
    var status : Bool?
    var result : Offer?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        result <- map["result"]
    }
    
    
}


