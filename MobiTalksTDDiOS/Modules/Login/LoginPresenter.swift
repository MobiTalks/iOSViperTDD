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
    var interactor: LoginInteractorInput?
    
    private var inputedEmail: String?
    private var inputedPassword: String?

    // MARK: public methods
    
    init(router: LoginRoutering) {
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
            let login = Login.init(email: inputedEmail ?? "", password: inputedPassword ?? "")
            interactor?.validateLogin(login)
        } else {
            router.presentAlert(
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
    func loginValidationSucceded() {
        view?.hideLoading()
        router.navigateToHome()
    }
    
    func loginValidateFailed() {
        view?.hideLoading()
        router.presentAlert(
            title: "error_title".localized(tableName: "Login"),
            message: "error_message".localized(tableName: "Login")
        )
    }
}
