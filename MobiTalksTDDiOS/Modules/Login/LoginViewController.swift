//
//  ViewController.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on 07/11/18.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import UIKit
import Lottie
import Foundation

class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gpromed_icon_large")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backgoundGradientLayer = GradientBackgroundLayer()
    private let loginButton = ContinueButton(fontSize: 14).systemType()
    private let emailTextField = LoginTextField(fontSize: 18, inputType: .email)
    private let passwordTextField = LoginTextField(fontSize: 18, inputType: .password)
    private var loaderView = LOTAnimationView()
    
    let presenter: LoginPresenter
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupObservers()
        presenter.attachView(view: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -70 // Move view 150 points upward
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    private func setupObservers() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTouchedUpInside), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LoginViewController.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func emailTextFieldDidChange() {
        presenter.emailInputDidChange(emailTextField.text ?? "")
    }
    
    @objc private func passwordTextFieldDidChange() {
        presenter.passwordInputDidChange(passwordTextField.text ?? "")
    }
    
    @objc private func loginButtonTouchedUpInside() {
        presenter.primaryActionSelected()
    }
    
    private func setupLayout() {
        view.layer.addSublayer(backgoundGradientLayer)
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        //TODO: Implementar screenbased para atuar sobre todos modelos de tela
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: view.frame.height * 0.10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            ])
    }
}

extension LoginViewController: LoginView {
    func showLoading() {
        addLoaderView()
        loaderView.play()
    }
    
    func hideLoading() {
        loaderView.pause()
        dispatch_queue_main_t.main.async {
            self.loaderView.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func setLoginPlaceholder(_ text: String) {
        emailTextField.placeholder = text
    }
    
    func setPasswordPlaceholder(_ text: String) {
        passwordTextField.placeholder = text
    }
    
    func setPrimaryActionTitle(_ text: String) {
        loginButton.setTitle(text, for: .normal)
    }
}

extension LoginViewController {
    private func addLoaderView() {
        loaderView.removeFromSuperview()
        loaderView = LOTAnimationView(name: "heartrate.json")
        loaderView.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.7)
        loaderView.frame.size = view.frame.size
        loaderView.contentMode = .scaleAspectFit
        loaderView.center = self.view.center
        loaderView.loopAnimation = true
        loaderView.animationSpeed = 0.5
        
        view.addSubview(loaderView)
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
}

