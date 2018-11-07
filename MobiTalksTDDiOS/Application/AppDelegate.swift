//
//  AppDelegate.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setLoginAsRootViewController()
        return true
    }

    // MARK: Private methods
    
    private func setLoginAsRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginRouter().buildModule()
        window?.makeKeyAndVisible()
    }
    
    private func setHomeAsRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeRouter().buildModule()
        window?.makeKeyAndVisible()
    }
    
    // MARK: Public methods
    
    func executeLogout(){
        setLoginAsRootViewController()
    }
    
    func executeLogin(){
        setHomeAsRootViewController()
    }

}

