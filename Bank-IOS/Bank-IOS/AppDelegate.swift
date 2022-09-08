//
//  AppDelegate.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window? .makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
//        window?.rootViewController = LoginViewController()
        window?.rootViewController = OnboardingContainerViewController()
//        window?.rootViewController = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in the 1989")
        return true
    }
    
    

}

