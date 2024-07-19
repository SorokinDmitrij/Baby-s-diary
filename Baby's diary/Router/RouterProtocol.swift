//
//  RouterProtocol.swift
//  Baby's diary
//
//  Created by mac on 09.07.2024.
//

protocol RouterProtocol: AnyObject {
    func start()
    func showOnboarding()
    func showMainScreen()
    func presentConfirmationAlert(_ title: String, message: String?, onConfirmation: @escaping () -> Void)
}
