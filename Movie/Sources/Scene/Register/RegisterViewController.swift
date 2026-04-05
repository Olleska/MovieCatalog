//
//  RegisterViewController.swift
//  Movie
//
//  Created by Олеся Лыжина on 17.10.2025.
//

import UIKit
import Alamofire

final class RegisterViewController: UIViewController {
    private let logoImage = UIImageView()
    private let registerNameButton = UIButton()
    private let loginText = UITextField()
    private let emailText = UITextField()
    private let nameText = UITextField()
    private let passwordText = UITextField()
    private let reallyPasswordText = UITextField()
    private let dateOfBirthTextField = UITextField()
    private let maleButton = UIButton()
    private let femaleButton = UIButton()
    private var selectedGender: Gender = .none
    private var selectedDate = Date()
    private let textColor = UIColor(named: "colorTextField")
    private let borderColor = UIColor(named: "colorBorderField")
    private let dateTextBackend = UITextField()

    enum Gender: Int {
        case male = 0
        case female = 1
        case none = 2
    }
    struct Post: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    private let registerButton = UIButton()
    private let loginBackButton = UIButton()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setup()
    }
    private func setup() {
        setupLogoImage()
        setupRegisterNameButton()
        setupLoginText()
        setupEmailText()
        setupNameText()
        setupPasswordText()
        setupReallyPasswordText()
        setupRegisterButton()
        setupLoginBackButton()
        setupDateOfBirthField()
        setupGenderSelection()
        loginText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        nameText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        dateOfBirthTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        updateRegisterButtonState()
    }
    @objc private func textFieldDidChange() {
        updateRegisterButtonState()
    }
    private func setupLogoImage() {
        logoImage.image = UIImage(named: "splash")
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 147),
            logoImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func setupRegisterNameButton() {
        registerNameButton.setTitle("Регистрация", for: .normal)
        registerNameButton.contentHorizontalAlignment = .left
        registerNameButton.backgroundColor = .background
        registerNameButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        registerNameButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Bold", size: 24)
        registerNameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerNameButton)
        NSLayoutConstraint.activate([
            registerNameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 156),
            registerNameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            registerNameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            registerNameButton.heightAnchor.constraint(equalToConstant: 32)
        ])
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
            loginText.topAnchor.constraint(equalTo: registerNameButton.bottomAnchor, constant: 16),
            loginText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupEmailText() {
        emailText.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [
                .foregroundColor: textColor!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        emailText.textColor = UIColor(named: "textColor")
        emailText.backgroundColor = UIColor.background
        emailText.layer.borderColor = borderColor?.cgColor
        emailText.layer.borderWidth = 1
        emailText.layer.cornerRadius = 8
        emailText.autocapitalizationType = .none
        emailText.autocorrectionType = .no
        emailText.spellCheckingType = .no
        emailText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        emailText.leftViewMode = .always
        emailText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailText)
        NSLayoutConstraint.activate([
            emailText.topAnchor.constraint(equalTo: loginText.bottomAnchor, constant: 16),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupNameText() {
        nameText.attributedPlaceholder = NSAttributedString(
            string: "Имя",
            attributes: [
                .foregroundColor: textColor!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        nameText.textColor = UIColor(named: "textColor")
        nameText.backgroundColor = UIColor.background
        nameText.layer.borderColor = borderColor?.cgColor
        nameText.layer.borderWidth = 1
        nameText.layer.cornerRadius = 8
        nameText.autocapitalizationType = .none
        nameText.autocorrectionType = .no
        nameText.spellCheckingType = .no
        nameText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        nameText.leftViewMode = .always
        nameText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameText)
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 16),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameText.heightAnchor.constraint(equalToConstant: 44)
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
            passwordText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 16),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupReallyPasswordText() {
        reallyPasswordText.attributedPlaceholder = NSAttributedString(
            string: "Подтвердите пароль",
            attributes: [
                .foregroundColor: textColor!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        reallyPasswordText.textColor = UIColor(named: "textColor")
        reallyPasswordText.backgroundColor = UIColor.background
        reallyPasswordText.layer.borderColor = borderColor?.cgColor
        reallyPasswordText.layer.borderWidth = 1
        reallyPasswordText.layer.cornerRadius = 8
        reallyPasswordText.autocapitalizationType = .none
        reallyPasswordText.autocorrectionType = .no
        reallyPasswordText.spellCheckingType = .no
        reallyPasswordText.isSecureTextEntry = true
        reallyPasswordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        reallyPasswordText.leftViewMode = .always
        reallyPasswordText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reallyPasswordText)
        NSLayoutConstraint.activate([
            reallyPasswordText.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 16),
            reallyPasswordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            reallyPasswordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            reallyPasswordText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupDateOfBirthField() {
        dateOfBirthTextField.attributedPlaceholder = NSAttributedString(
            string: "Дата рождения",
            attributes: [
                .foregroundColor: textColor!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        dateOfBirthTextField.textColor = UIColor(named: "textColor")
        dateOfBirthTextField.backgroundColor = UIColor.background
        dateOfBirthTextField.layer.borderColor = borderColor?.cgColor
        dateOfBirthTextField.layer.borderWidth = 1
        dateOfBirthTextField.layer.cornerRadius = 8
        dateOfBirthTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        dateOfBirthTextField.leftViewMode = .always
        let icon = UIImageView(image: UIImage(named: "calendarIcon"))
        icon.tintColor = UIColor.gray
        icon.contentMode = .scaleAspectFit
        icon.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        dateOfBirthTextField.rightView = icon
        dateOfBirthTextField.rightViewMode = .always
        dateOfBirthTextField.isUserInteractionEnabled = true
        dateOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateOfBirthTextField)
        NSLayoutConstraint.activate([
            dateOfBirthTextField.topAnchor.constraint(equalTo: reallyPasswordText.bottomAnchor, constant: 16),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        dateOfBirthTextField.addGestureRecognizer(tap)
    }
    @objc private func showDatePicker() {
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.tag = 100
            
        let tapBackground = UITapGestureRecognizer(target: self, action: #selector(closeDatePicker))
        backgroundView.addGestureRecognizer(tapBackground)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = Locale(identifier: "en_EN")
        datePicker.maximumDate = Date()
        datePicker.tintColor = UIColor(named: "textColor")
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.layer.cornerRadius = 13
        datePicker.clipsToBounds = true
        datePicker.backgroundColor = UIColor(named: "systemBackground")
        datePicker.setDate(selectedDate, animated: false)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.tag = 101
        
        view.addSubview(backgroundView)
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: 343),
            datePicker.heightAnchor.constraint(equalToConstant: 327)
        ])
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    @objc private func closeDatePicker() {
        view.viewWithTag(100)?.removeFromSuperview()
        view.viewWithTag(101)?.removeFromSuperview()
    }
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
        let formatterScreen = DateFormatter()
        formatterScreen.dateFormat = "yyyy-MM-dd"
        self.dateOfBirthTextField.text = formatterScreen.string(from: sender.date)
        let formatterBackend = DateFormatter()
        formatterBackend.dateFormat = "yyyy-MM-dd"
        self.dateTextBackend.text = formatterBackend.string(from: sender.date)
    }
    private func setupGenderSelection() {
        maleButton.setTitle("Мужчина", for: .normal)
        femaleButton.setTitle("Женщина", for: .normal)
        maleButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
        femaleButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
        maleButton.backgroundColor = UIColor(named: "backgroundColor")
        femaleButton.backgroundColor = UIColor(named: "backgroundColor")
        maleButton.setTitleColor(UIColor(named: "colorTextField"), for: .normal)
        femaleButton.setTitleColor(UIColor(named: "colorTextField"), for: .normal)
        
        let genderStack = UIStackView(arrangedSubviews: [maleButton, femaleButton])
        genderStack.axis = .horizontal
        genderStack.distribution = .fillEqually
        genderStack.spacing = 1
        
        genderStack.backgroundColor = borderColor
        genderStack.layer.borderColor = borderColor?.cgColor
        genderStack.layer.borderWidth = 1
        genderStack.layer.cornerRadius = 8
        genderStack.clipsToBounds = true
        
        genderStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderStack)
        
        NSLayoutConstraint.activate([
            genderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genderStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            genderStack.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: 16),
            genderStack.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        maleButton.addTarget(self, action: #selector(genderSelected(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderSelected(_:)), for: .touchUpInside)
        maleButton.tag = 0
        femaleButton.tag = 1
    }

    @objc private func genderSelected(_ sender: UIButton) {
        selectedGender = sender.tag == 0 ? .male : .female
        updateGenderSelection()
        updateRegisterButtonState()
    }

    private func updateGenderSelection() {
        let activeColor = UIColor(named: "textColor")
        
        if selectedGender == .male {
            maleButton.backgroundColor = activeColor
            maleButton.setTitleColor(.colorTextField, for: .normal)
            
            femaleButton.backgroundColor = .background
            femaleButton.setTitleColor(.colorTextField, for: .normal)
        } else if selectedGender == .female {
            femaleButton.backgroundColor = activeColor
            femaleButton.setTitleColor(.colorTextField, for: .normal)
            
            maleButton.backgroundColor = .background
            maleButton.setTitleColor(.colorTextField, for: .normal)
        }
    }
    private func updateRegisterButtonState() {
        let isLoginFilled = !(loginText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isEmailFilled = !(emailText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isNameFilled = !(nameText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isPasswordFilled = !(passwordText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isReallyPasswordFilled = !(reallyPasswordText.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isDateFilled = !(dateOfBirthTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isGenderFilled = selectedGender != .none
        let isEnabled = isLoginFilled && isEmailFilled && isNameFilled && isPasswordFilled && isReallyPasswordFilled && isDateFilled && isGenderFilled

        if isEnabled {
            registerButton.backgroundColor = UIColor(named: "textColor")
            registerButton.setTitleColor(UIColor(named:"baseColor"), for: .normal)
            registerButton.layer.borderColor = UIColor(named:"textColor")?.cgColor
        } else {
            registerButton.backgroundColor = .background
            registerButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
            registerButton.layer.borderColor = borderColor?.cgColor
        }
    }
    @objc private func didTapRegistrationButton() {
        guard let username = loginText.text, !username.isEmpty,
              let email = emailText.text, !email.isEmpty,
              let name = nameText.text, !name.isEmpty,
              let password = passwordText.text, !password.isEmpty,
              let checkPassword = reallyPasswordText.text, !checkPassword.isEmpty,
              let date = dateOfBirthTextField.text, !date.isEmpty
        else {
                print ("не все поля заполнены")
                return
            }
        let gender = selectedGender == .male ? 0 : 1
        if password != checkPassword {
            print("пароли должны совпадать")
            return
        }
        else {
            AuthService.shared.registration(userName: username, name: name, password: password, email: email, birthDate: date, gender: gender) { result in
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
    }
    private func setupRegisterButton() {
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 4
        registerButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -96),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registerButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        registerButton.addTarget(self, action: #selector(didTapRegistrationButton), for: .touchUpInside)
    }
    private func setupLoginBackButton() {
        loginBackButton.setTitle("У меня уже есть аккаунт", for: .normal)
        loginBackButton.backgroundColor = .background
        loginBackButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        loginBackButton.layer.borderColor = UIColor.background.cgColor
        loginBackButton.layer.borderWidth = 1
        loginBackButton.layer.cornerRadius = 4
        loginBackButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        loginBackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginBackButton)
        NSLayoutConstraint.activate([
            loginBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -38),
            loginBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            loginBackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            loginBackButton.heightAnchor.constraint(equalToConstant: 32),
        ])
        loginBackButton.addTarget(self, action: #selector(didTapLoginBackButton), for: .touchUpInside)
    }
    @objc func didTapLoginBackButton() {
        let loginVC = LoginViewController()
        navigationController?.setViewControllers([loginVC], animated: false)
    }
}
