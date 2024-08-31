//
//  LoginViewController.swift
//  Baby's diary
//
//  Created by mac on 28.07.2024.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthCombineSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    weak var router: RouterProtocol?
    
    // UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Электронная почта"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    private lazy var emailValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    private lazy var passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    private lazy var invalidCredentialsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var stripeView: UIView = {
        let view = UIView()
        view.alpha = 0.5
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет аккаунта?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизуемся ..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    private lazy var overlayView: UIView = {
            let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.isHidden = true
            return view
        }()
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    private var forgotPasswordButtonTopConstraint: NSLayoutConstraint!
    private var loadingStackViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    private func setupUI() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(mainStackView)
        view.addSubview(bottomStackView)
        view.addSubview(activityIndicator)
        view.addSubview(loadingLabel)
        view.addSubview(overlayView)
        view.addSubview(stripeView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(emailValidationLabel)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(passwordValidationLabel)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(invalidCredentialsLabel)
        mainStackView.addArrangedSubview(forgotPasswordButton)
        
        bottomStackView.addArrangedSubview(noAccountLabel)
        bottomStackView.addArrangedSubview(signUpButton)
    }
    private func setupConstraints() {
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
            bottomStackView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            loadingLabel.translatesAutoresizingMaskIntoConstraints = false
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            stripeView.translatesAutoresizingMaskIntoConstraints = false
         
          forgotPasswordButtonTopConstraint = forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10)
          loadingStackViewTopConstraint = loadingLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40)
                
          NSLayoutConstraint.activate([
                mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                loginButton.heightAnchor.constraint(equalToConstant: 40),
                forgotPasswordButtonTopConstraint,
                forgotPasswordButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
                
                bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
                stripeView.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: -50),
                stripeView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                stripeView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:  -20),
                stripeView.heightAnchor.constraint(equalToConstant: 2),
                
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingStackViewTopConstraint,
                
                overlayView.topAnchor.constraint(equalTo: view.topAnchor),
                overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    @objc private func loginButtonTapped() {
        view.endEditing(true)
        // Hide all validation labels initially
        emailValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        invalidCredentialsLabel.isHidden = true
        
        guard let email = emailTextField.text, !email.isEmpty else {
            emailValidationLabel.text = "Введите электронную почту"
            emailValidationLabel.isHidden = false
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordValidationLabel.text = "Введите пароль"
            passwordValidationLabel.isHidden = false
            return
        }
        if password.count < 6 {
            passwordValidationLabel.text = "Пароль слишком короткий"
            passwordValidationLabel.isHidden = false
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        // Show the activity indicator and loading label
        activityIndicator.startAnimating()
        loadingLabel.isHidden = false
        overlayView.isHidden = false
        
        // Выполняем вход с использованием AuthCredential
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                DispatchQueue.main.async {
                    // Прячем индикатор активности и текст загрузки
                    self?.activityIndicator.stopAnimating()
                    self?.loadingLabel.isHidden = true
                    self?.overlayView.isHidden = true
                    
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        self?.invalidCredentialsLabel.text = "Предоставленные учетные данные аутентификации неверны или срок их действия истек."
                        self?.invalidCredentialsLabel.isHidden = false
                        
                        // Изменяем позицию кнопки "Забыли пароль" при ошибке
                        self?.forgotPasswordButtonTopConstraint.constant = 50
                        UIView.animate(withDuration: 0.3) {
                            self?.view.layoutIfNeeded()
                        }
                        return
                    }
                    
                    // Возвращаем кнопку "Забыли пароль" на место при успешной аутентификации
                    self?.forgotPasswordButtonTopConstraint.constant = 10
                    UIView.animate(withDuration: 0.3) {
                        self?.view.layoutIfNeeded()
                    }
                }
            }
    }
    @objc private func forgotPasswordButtonTapped() {
        // Handle forgot password action
    }
    
    @objc private func signUpButtonTapped() {
        // Navigate to the sign-up screen
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            addDoneButtonOnKeyboard(textField: textField)
        }
    }
    private func addDoneButtonOnKeyboard(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([flexSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
}
