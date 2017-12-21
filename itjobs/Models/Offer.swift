//
//  Offer.swift
//  itjobs
//
//  Created by Piotrek on 03.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import ObjectMapper
import Foundation

class Offer: Mappable {
    var id : Int?
    var is_active : Int?
    var language : String?
    var title : String?
    var city : String?
    var contract_type : String?
    var lower_salary : Int?
    var upper_salary : Int?
    var work_mode : [String]?
    var publication_date : String?
    var id_company : Int?
    var description : String?
    var requirements : [String]?
    var technologies : [String]?
    var languages : [String]?
    var methodology : [Methodology]?
    var specifics : [Specifics]?
    var equipment : [Equipment]?
    var bonuses : [Bonuses]?
    var id_from_www : Int?
    var name : String?
    var logo : String?
    var website : String?
    var address : String?
    var employees : String?
    var capital : String?
    
    init() {
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        is_active <- map["is_active"]
        language <- map["language"]
        title <- map["title"]
        city <- map["city"]
        contract_type <- map["contract_type"]
        lower_salary <- map["lower_salary"]
        upper_salary <- map["upper_salary"]
        work_mode <- map["work_mode"]
        publication_date <- map["publication_date"]
        id_company <- map["id_company"]
        description <- map["description"]
        requirements <- map["requirements"]
        technologies <- map["technologies"]
        languages <- map["languages"]
        methodology <- map["methodology"]
        specifics <- map["specifics"]
        equipment <- map["equipment"]
        bonuses <- map["bonuses"]
        id_from_www <- map["id_from_www"]
        name <- map["name"]
        logo <- map["logo"]
        website <- map["website"]
        address <- map["address"]
        employees <- map["employees"]
        capital <- map["capital"]
    }
    
}
