//
//  BaseService.swift
//  itjobs
//
//  Created by Piotrek on 02.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation

class Api {
    
    func baseUrl() -> String? {
        if let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String {
            return baseURL
        } else {
            return nil
        }
    }
    
}
