//
//  ViewController.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import UIKit
import Lottie
import Foundation

class LoginViewController: UIViewController {
    
    // MARK: Properties

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        return button
    }()
    
    private let backgoundGradientLayer = GradientBackgroundLayer()
    private let emailTextField = LoginTextField(fontSize: 18, inputType: .email)
    private let passwordTextField = LoginTextField(fontSize: 18, inputType: .password)
    private var loaderView = LOTAnimationView()
    private var mobiView = LOTAnimationView()
    
    let presenter: LoginPresenter
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Lifecycle
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupObservers()
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addMobiAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Private methods
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -70 // Move view 150 points upward
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    private func addMobiAnimation() {
        mobiView.removeFromSuperview()
        mobiView = LOTAnimationView(name: "mobi.json")
        mobiView.backgroundColor = .clear
        mobiView.frame.size = CGSize(width: view.frame.width, height: view.frame.height * 0.15)
        mobiView.contentMode = .scaleAspectFit
        mobiView.frame.origin = CGPoint(x: 0, y: view.frame.height * 0.10)
        mobiView.loopAnimation = true
        mobiView.animationSpeed = 0.7
        
        view.addSubview(mobiView)
        mobiView.play()
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
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        //TODO: Implementar screenbased para atuar sobre todos modelos de tela
        NSLayoutConstraint.activate([
            
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.3),
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
        loaderView = LOTAnimationView(name: "glow_loading.json")
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

