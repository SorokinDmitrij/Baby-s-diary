//
//  Router.swift
//  Baby's diary
//
//  Created by mac on 09.07.2024.
//
import UIKit

class Router: RouterProtocol {
    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        if UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
            showMainScreen()
        } else {
            showOnboarding()
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func showOnboarding() {
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.router = self
        navigationController.setViewControllers([onboardingViewController], animated: false)
    }

    func showMainScreen() {
        let tabBarController = MainTabBarController()
        tabBarController.router = self
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func presentConfirmationAlert(_ title: String, message: String?, onConfirmation: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { _ in
            onConfirmation()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
