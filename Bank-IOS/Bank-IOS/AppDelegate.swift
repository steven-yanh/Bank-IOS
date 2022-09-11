//
//  AppDelegate.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/3/22.
//

import UIKit

let appColor = UIColor.systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    
    let OnboardingViewController = OnboardingContainerViewController()
    
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window? .makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        OnboardingViewController.delegate = self
        
        let vc = MainViewController()
        vc.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc
        
        return true
    }
    
    

}
//MARK: - Login Delegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin(_ sender: LoginViewController) {
        let hasBoarded = LocalState.hasOnboarded
        if hasBoarded {
            setRootVC(mainViewController)
        }else {
            setRootVC(OnboardingViewController)
        }
    }
}

//MARK: - Onboarding Delegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding(_ sender: OnboardingContainerViewController) {
        LocalState.hasOnboarded = true
        setRootVC(mainViewController)
    }
}

//MARK: - Logout Delegate
extension AppDelegate: logoutDelegate {
    func didLogout() {
        setRootVC(loginViewController)
        
    }
}



//MARK: - Animation transition between VC
extension AppDelegate {
    func setRootVC (_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
