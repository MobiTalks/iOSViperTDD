//
//  LoginRouter.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import UIKit

class LoginRouter {
    
    weak var view: UIViewController?
    
    func buildModule() -> UIViewController {
        let router = LoginRouter()
        let presenter = LoginPresenter(router: router)
        let interactor = LoginInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        let viewController = LoginViewController(presenter: presenter)
        router.view = viewController
        return viewController
    }
}

extension LoginRouter: LoginRoutering {
    func presentAlert(title: String, message: String) {
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
