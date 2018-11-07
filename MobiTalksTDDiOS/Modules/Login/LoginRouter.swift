//
//  LoginRouter.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on 07/11/18.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import UIKit

class LoginRouter {
    
    weak var view: UIViewController?
    
    func buildModule() -> UIViewController {
        let router = LoginRouter()
        let presenter = LoginPresenter(router: router)
        let services = LoginInteractor()
        services.output = presenter
        presenter.interactor = interactor
        let viewController = LoginViewController(presenter: presenter)
        router.view = viewController
        return viewController
    }
}

extension LoginRouter: LoginWireFrame {
    func showLoginError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        view?.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToHome() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        dispatch_queue_main_t.main.async {
            delegate.executeLogin()
        }
    }
}
