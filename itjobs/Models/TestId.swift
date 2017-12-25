//
//  TestId.swift
//  itjobs
//
//  Created by Piotrek on 25.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class TestId:Mappable {
    var id_test : String?

    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id_test <- map["id_test"]
    }
    
    
}


