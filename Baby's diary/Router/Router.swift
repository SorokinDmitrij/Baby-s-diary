//
//  Router.swift
//  Baby's diary
//
//  Created by mac on 09.07.2024.
//
import UIKit
import FirebaseAuth

class Router: RouterProtocol {
    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    func showLoginScreen() {
        let loginViewController = LoginViewController()
        loginViewController.router = self
        navigationController.setViewControllers([loginViewController], animated: false)
    }
    // Навигация на следующий экран
    func navigateToNextScreen(from viewController: UIViewController) {
        let addBabyViewController = AddBabyViewController()
        addBabyViewController.router = self
        navigationController.pushViewController(addBabyViewController, animated: true)
    }

    // Начальная настройка приложения
    func start() {
        if !isUserLoggedIn() {
               showLoginScreen()
           } else if UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
               showLoginScreen()
           } else {
               showOnboarding()
           }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    private func isUserLoggedIn() -> Bool {
        // Проверьте, авторизован ли пользователь (например, через Firebase или другой сервис авторизации)
        return Auth.auth().currentUser != nil
    }

    // Показ экрана онбординга
    func showOnboarding() {
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.router = self
        navigationController.setViewControllers([onboardingViewController], animated: false)
    }

    // Показ главного экрана с таббаром
    func showMainScreen() {
        let tabBarController = MainTabBarController()
        tabBarController.router = self
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    // Показ диалогового окна подтверждения
    func presentConfirmationAlert(_ title: String, message: String?, onConfirmation: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { _ in
            onConfirmation()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        // Представляем алерт через верхний видимый контроллер
        navigationController.topViewController?.present(alertController, animated: true, completion: nil)
    }
}
