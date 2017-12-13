//
//  SwiftMessage.swift
//  itjobs
//
//  Created by Piotrek on 13.12.2017.
//  Copyright © 2017 Piotr Smajek. All rights reserved.
//

import Foundation
import SwiftMessages

class SwiftMessage {
    
    func errorMessage(title: String, body: String) {
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 1)
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.button?.isHidden = true
        view.configureDropShadow()
        let iconText = "😥"
        view.tapHandler = { _ in SwiftMessages.hide() }
        view.configureContent(title: title, body: body, iconText: iconText)
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func successMessage(title: String, body: String) {
        var config = SwiftMessages.Config()
        config.duration = .forever
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.button?.isHidden = true
        view.configureDropShadow()
        let iconText = "😄"
        view.tapHandler = { _ in SwiftMessages.hide() }
        view.configureContent(title: title, body: body, iconText: iconText)
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func hideMessage() {
        SwiftMessages.hide()
    }
    
}
