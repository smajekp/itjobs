//
//  UITextField+PlaceholderColor.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation

import UIKit

extension UITextField {
    
    func placeholderColor(color: UIColor) {
        if let placeholder = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string:placeholder,
                                                                 attributes: [NSAttributedStringKey.foregroundColor: color])
        }
    }
    
}
