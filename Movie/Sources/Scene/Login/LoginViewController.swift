//
//  LoginViewController.swift
//  Movie
//
//  Created by Олеся Лыжина on 17.10.2025.
//

import UIKit

final class LoginViewController: UIViewController {
    private let logoImage = UIImageView()
    private var loginText = UITextField()
    private let passwordText = UITextField()
    private let loginButton = UIButton()
    private let registerButton = UIButton()
    private let textColor = UIColor(named: "colorTextField")
    private let borderColor = UIColor(named: "colorBorderField")
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
         fatalError("init has not been realized yet")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setup()
    }
    private func setup() {
        setupLogoImage()
        setupLoginText()
        setupPasswordText()
        setupLoginButton()
        setupRegisterButton()
        loginText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        updateLoginButtonState()
    }
    @objc private func textFieldDidChange() {
        updateLoginButtonState()
    }
    private func setupLoginText() {
        loginText.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [
                .foregroundColor: textColor!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        loginText.textColor = UIColor(named: "textColor")
        loginText.backgroundColor = UIColor.background
        loginText.layer.borderColor = borderColor?.cgColor
        loginText.layer.borderWidth = 1
        loginText.layer.cornerRadius = 8
        loginText.autocapitalizationType = .none
        loginText.autocorrectionType = .no
        loginText.spellCheckingType = .no
        loginText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        loginText.leftViewMode = .always
        loginText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginText)
        NSLayoutConstraint.activate([
            loginText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 297),
            loginText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupPasswordText() {
        passwordText.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [
                .foregroundColor: textColor!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        passwordText.textColor = UIColor(named: "textColor")
        passwordText.backgroundColor = UIColor.background
        passwordText.layer.borderColor = borderColor?.cgColor
        passwordText.layer.borderWidth = 1
        passwordText.layer.cornerRadius = 8
        passwordText.autocapitalizationType = .none
        passwordText.autocorrectionType = .no
        passwordText.spellCheckingType = .no
        passwordText.isSecureTextEntry = true
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        passwordText.leftViewMode = .always
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordText)
        NSLayoutConstraint.activate([
            passwordText.topAnchor.constraint(equalTo: loginText.bottomAnchor, constant: 16),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupRegisterButton() {
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.backgroundColor = .background
        registerButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        registerButton.layer.borderColor = UIColor.background.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 4
        registerButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -38),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registerButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    private func setupLoginButton() {
        loginButton.setTitle("Войти", for: .normal)
        loginButton.layer.borderColor = borderColor?.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 4
        loginButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -96),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    @objc private func didTapLoginButton() {
        guard let username = loginText.text, !username.isEmpty,
              let password = passwordText.text, !password.isEmpty
        else {
                return
            }
        AuthService.shared.login(username: username, password: password) { result in
                    switch result {
                    case .success(let token):
                        print("успешно! токен: \(token)")
                        UserDefaults.standard.set(token, forKey: "userToken")
                        let mainScreenVC = MainViewController()
                        self.navigationController?.setViewControllers([mainScreenVC], animated: false)
                        let tabBarVC = MainTabBarController()
                        if let window = self.view.window {
                                window.rootViewController = tabBarVC
                        }
                    case .failure(let error):
                        print("ошибка \(error.localizedDescription)")
                    }
            }
    }
    
    @objc private func didTapRegisterButton() {
        let registerVC = RegisterViewController()
        navigationController?.setViewControllers([registerVC], animated: false)
    }
    private func updateLoginButtonState() {
        let isLoginFilled = !(loginText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isPasswordFilled = !(passwordText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isEnabled = isLoginFilled && isPasswordFilled

        if isEnabled {
            loginButton.backgroundColor = UIColor(named: "textColor")
            loginButton.setTitleColor(UIColor(named:"baseColor"), for: .normal)
            loginButton.layer.borderColor = UIColor(named:"textColor")?.cgColor
        } else {
            loginButton.backgroundColor = .background
            loginButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
            loginButton.layer.borderColor = borderColor?.cgColor
        }
    }
    private func setupLogoImage() {
        logoImage.image = UIImage(named: "splash")
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
            logoImage.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}
