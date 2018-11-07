//
//  LoginProtocols.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Foundation

protocol LoginView: class {
    func setLoginPlaceholder(_ text: String)
    func setPasswordPlaceholder(_ text: String)
    func setPrimaryActionTitle(_ text: String)
    func showLoading()
    func hideLoading()
}

protocol LoginRoutering: class {
    func presentAlert(title: String, message: String)
    func navigateToHome()
}

protocol LoginInteractorInput: class {
    func validateLogin(_ login: Login)
}

protocol LoginInteractorOutput: class {
    func loginValidationSucceded()
    func loginValidateFailed()
}
