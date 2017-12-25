//
//  Question.swift
//  itjobs
//
//  Created by Piotrek on 25.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import ObjectMapper

class Question:Mappable {
    var question : String?
    var answer1 : String?
    var answer2 : String?
    var answer3 : String?
    var answer4 : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        question <- map["question"]
        answer1 <- map["answer1"]
        answer2 <- map["answer2"]
        answer3 <- map["answer3"]
        answer4 <- map["answer4"]
    }
    
    
}

