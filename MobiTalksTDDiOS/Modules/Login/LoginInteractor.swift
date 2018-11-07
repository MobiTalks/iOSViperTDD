//
//  LoginInteractor.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Foundation

class LoginInteractor {
    // MARK: Properties
    let apiHandler = API()
    weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
    func validateLogin(_ login: Login) {
        
        apiHandler.request(url: [.base, .login], parameters: login.toDict(), httpMethod: .post) { [weak self] (response: LoginSuccess?, error: String?) in
            guard let self = self else { return }
            guard error == nil else {
                self.output?.loginValidateFailed()
                return
            }
            guard let `response` = response else {
                self.output?.loginValidateFailed()
                return
            }
            self.output?.loginValidationSucceded(userData: response)
        }
    }
}
