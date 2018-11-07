//
//  LoginPresenter.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    // MARK: Private properties
    
    private weak var view: LoginView?
    private var router: LoginRoutering
    var services: LoginInteractorInput?
    
    private var inputedEmail: String?
    private var inputedPassword: String?

    // MARK: public methods
    
    init(router: LoginWireFrame) {
        self.router = router
    }
    
    func attachView(view: LoginView) {
        self.view = view
        view.setLoginPlaceholder("email_placeholder".localized(tableName: "Login"))
        view.setPasswordPlaceholder("senha_placeholder".localized(tableName: "Login"))
        view.setPrimaryActionTitle("entrar".localized(tableName: "Login"))
    }
    
    // MARK: Public methods
    
    func primaryActionSelected() {
        if (inputedEmail ?? "").isValidEmail() && !(inputedPassword ?? "").isEmpty {
            view?.showLoading()
            let login = Login.init(user: inputedEmail ?? "", pass: inputedPassword ?? "")
            interactor?.validateLogin(login)
        } else {
            router.showLoginError(
                title: "error_title".localized(tableName: "Login"),
                message: "error_message".localized(tableName: "Login")
            )
        }
    }
    
    func emailInputDidChange(_ text: String) {
        inputedEmail = text
    }
    
    func passwordInputDidChange(_ text: String) {
        inputedPassword = text
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func loginValidationSucceded(userData: LoginSuccess) {
        view?.hideLoading()
        router.navigateToCameraScene()
    }
    
    func loginValidateFailed() {
        view?.hideLoading()
        router.showError(
            title: "error_title".localized(tableName: "Login"),
            message: "error_message".localized(tableName: "Login")
        )
    }
}
