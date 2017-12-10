//
//  UITextField+BottomBorder.swift
//  itjobs
//
//  Created by Piotrek on 09.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder() {
        let border = CALayer()
        let width = CGFloat(1.0)
        let color = UIColor(rgb: 0x90bec6)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
