//
//  File.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setupButton()
    }
    
    private func setupButton() {
        button.frame = CGRect(x: view.frame.width*0.25, y: view.frame.height/4, width: view.frame.width*0.6, height: view.frame.height*0.2)
        button.setTitle("LOGOUT", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.frame.size = CGSize(width: view.frame.width*0.5, height: view.frame.height*0.1)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    @objc private func buttonTouched() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        dispatch_queue_main_t.main.async {
            delegate.executeLogout()
        }
    }
    
}
