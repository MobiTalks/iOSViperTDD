//
//  LoginPresenterTests.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Quick
import Nimble

@testable import MobiTalksTDDiOS

class LoginTests: QuickSpec {
    
    override func spec() {
        
        describe("LoginPresenter") {
            var router: LoginRouterSpy?
            var view: LoginViewSpy?
            var presenter: LoginPresenter?
            var interactor: LoginInteractorSpy?
            
            beforeEach {
                router = LoginRouterSpy()
                view = LoginViewSpy()
                interactor = LoginInteractorSpy()
                presenter = LoginPresenter(router: router!)
                presenter?.interactor = interactor
                
                presenter?.attachView(view: view!)
            }
            
            describe("quando a view for anexada") {
                
                it("deverá setar o placeholder do login") {
                    expect(view?.loginPlaceholderPassed) == "Insira seu email"
                    expect(view?.setLoginPlaceholderCalled) == true
                }
                
                it("deverá setar o placeholder da senha") {
                    expect(view?.passwordPlaceholderPassed) == "Insira sua senha"
                    expect(view?.setPasswordPlaceholderCalled) == true
                }
                
                it("deverá setar o título da ação primária") {
                    expect(view?.primaryActionTitlePassed) == "Entrar"
                    expect(view?.setPrimaryActionTitleCalled) == true
                }
            }
            
            describe("quando o usuário clicar na ação de continuar") {
                
                context("e o login for válido localmente") {
                    
                    beforeEach {
                        presenter?.emailInputDidChange("victorpanitz@gmail.com")
                        presenter?.passwordInputDidChange("mobitalks")
                        presenter?.primaryActionSelected()
                    }
                    
                    it("deverá mostar o loading feedback") {
                        expect(view?.showLoadingCalled) == true
                    }
                    
                    it("deverá validar o login inputado") {
                        expect(interactor?.validateLoginCalled) == true
                    }
                }
                
                context("e o login for inválido localmente") {
                    
                    it("deverá exibir um alerta de erro ao usuário") {
                        presenter?.emailInputDidChange("wrong")
                        presenter?.passwordInputDidChange("wrong")
                        presenter?.primaryActionSelected()
                        expect(router?.showAlertCalled) == true
                        expect(router?.errorMessagePassed) == "Dados de login inválidos."
                    }
                }
            }
            
            describe("quando a validação de login externa retornar") {
                
                context("com sucesso") {
                    
                    beforeEach{
                        presenter?.loginValidationSucceded()
                    }
                    
                    it("deverá esconder o loading"){
                        expect(view?.hideLoadingCalled) == true
                    }
                    
                    it("deverá chamar o método de navegação para a home"){
                        expect(router?.navigateToHomeCalled) == true
                    }
                }
                
                context("com erro") {
                    
                    beforeEach{
                        presenter?.loginValidateFailed()
                    }
                    
                    it("deverá esconder o loading"){
                        expect(view?.hideLoadingCalled) == true
                    }
                    
                    it("apresentar um alert de erro ao usuário"){
                        expect(router?.showAlertCalled) == true
                        expect(router?.errorMessagePassed) == "Dados de login inválidos."
                        expect(router?.errorTitlePassed) == "Ops!"
                    }
                }
            }
        }
    }
}

private class LoginViewSpy: LoginView {
    var loginPlaceholderPassed: String?
    var setLoginPlaceholderCalled: Bool?
    var passwordPlaceholderPassed: String?
    var setPasswordPlaceholderCalled: Bool?
    var primaryActionTitlePassed: String?
    var setPrimaryActionTitleCalled: Bool?
    var hideLoadingCalled: Bool?
    var showLoadingCalled: Bool?
    
    func setLoginPlaceholder(_ text: String) {
        loginPlaceholderPassed = text
        setLoginPlaceholderCalled = true
    }
    
    func setPasswordPlaceholder(_ text: String) {
        passwordPlaceholderPassed = text
        setPasswordPlaceholderCalled = true
    }
    
    func setPrimaryActionTitle(_ text: String) {
        primaryActionTitlePassed = text
        setPrimaryActionTitleCalled = true
    }
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
}

private class LoginRouterSpy: LoginRoutering {
    var navigateToHomeCalled: Bool?
    var showAlertCalled: Bool?
    var errorMessagePassed: String?
    var errorTitlePassed: String?
    
    func navigateToHome() {
        navigateToHomeCalled = true
    }
    
    func presentAlert(title: String, message: String) {
        showAlertCalled = true
        errorMessagePassed = message
        errorTitlePassed = title
    }
}

private class LoginInteractorSpy: LoginInteractorInput {
    var validateLoginCalled: Bool?
    
    func validateLogin(_ login: Login) {
        validateLoginCalled = true
    }
}
