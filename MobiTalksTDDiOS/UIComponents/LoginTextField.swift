//
//  LoginTextField.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on 07/11/18.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Foundation
import UIKit

enum InputType {
    case email
    case password
}

class LoginTextField: UITextField {
    
    init(fontSize: CGFloat, inputType: InputType) {
        super.init(frame: .zero)
        setup(fontSize: fontSize, inputType: inputType)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    private func setup(fontSize: CGFloat, inputType: InputType){
        switch inputType {
        case .email:
            keyboardType = .emailAddress
        case .password:
            keyboardType = .asciiCapable
            isSecureTextEntry = true
        }
        
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        font = UIFont(name: "Avenir", size: fontSize)
        textAlignment = .center
        setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        autocapitalizationType = .none
    }
}
