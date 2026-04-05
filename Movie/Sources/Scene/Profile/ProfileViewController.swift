//
//  ProfileViewController.swift
//  Movie
//
//  Created by Олеся Лыжина on 08.11.2025.
//

import UIKit

class ProfileViewController: UIViewController {
    private let nameText = UILabel()
    private let emailText = UILabel()
    private let dateOfBirthTextField = UILabel()
    private let maleButton = UIButton()
    private let femaleButton = UIButton()
    private let nameButton = UIButton()
    private let emailButton = UIButton()
    private let nameTextButton = UIButton()
    private let birthdayTextButton = UIButton()
    private let genderTextButton = UIButton()
    private let logoutButton = UIButton()
    private let borderColor = UIColor(named: "colorBorderField")!
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
        loadProfileData()
    }
    private func loadProfileData() {
        Task {
            do {
                let profile = try await AuthService.shared.getProfile()
                await MainActor.run {
                    
                }
            }
        }
    }
    private func setup() {
        setupNameButton()
        setupEmailButton()
        setupEmailText()
        setupNameTextButton()
        setupNameText()
        setupBirthdayTextButton()
        setupBirthdayText()
        setupGenderTextButton()
        setupGenderSelectButton()
        setupLogoutButton()
    }
    private func setupNameButton() {
        nameButton.setTitle("Тест", for: .normal)
        nameButton.contentHorizontalAlignment = .left
        nameButton.backgroundColor = .background
        nameButton.setTitleColor(UIColor(named: "textColorWithoutText"), for: .normal)
        nameButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Bold", size: 24)
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameButton)
        NSLayoutConstraint.activate([
            nameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            nameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameButton.heightAnchor.constraint(equalToConstant: 88)
        ])
    }
    private func setupEmailButton() {
        emailButton.setTitle("E-mail", for: .normal)
        emailButton.contentHorizontalAlignment = .left
        emailButton.backgroundColor = .background
        emailButton.setTitleColor(UIColor(named: "colorBorderField"), for: .normal)
        emailButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailButton)
        NSLayoutConstraint.activate([
            emailButton.topAnchor.constraint(equalTo: nameButton.bottomAnchor, constant: 32),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            emailButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    private func setupEmailText() {
        emailText.text = "test@test.ru"
        emailText.textAlignment = .left
        emailText.textColor = UIColor(named: "textColor")
        nameText.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        emailText.backgroundColor = UIColor.background
        emailText.layer.borderColor = borderColor.cgColor
        emailText.layer.borderWidth = 1
        emailText.layer.cornerRadius = 8
        emailText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailText)
        NSLayoutConstraint.activate([
            emailText.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 10),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupNameTextButton() {
        nameTextButton.setTitle("Имя", for: .normal)
        nameTextButton.contentHorizontalAlignment = .left
        nameTextButton.backgroundColor = .background
        nameTextButton.setTitleColor(UIColor(named: "colorBorderField"), for: .normal)
        nameTextButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        nameTextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextButton)
        NSLayoutConstraint.activate([
            nameTextButton.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 10),
            nameTextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            nameTextButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    private func setupNameText() {
        nameText.text = "Имя"
        nameText.textAlignment = .left
        nameText.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        nameText.textColor = UIColor(named: "textColor")
        nameText.backgroundColor = UIColor.background
        nameText.layer.borderColor = borderColor.cgColor
        nameText.layer.borderWidth = 1
        nameText.layer.cornerRadius = 8
        nameText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameText)
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: nameTextButton.bottomAnchor, constant: 10),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameText.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupBirthdayTextButton() {
        birthdayTextButton.setTitle("Дата рождения", for: .normal)
        birthdayTextButton.contentHorizontalAlignment = .left
        birthdayTextButton.backgroundColor = .background
        birthdayTextButton.setTitleColor(UIColor(named: "colorBorderField"), for: .normal)
        birthdayTextButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        birthdayTextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(birthdayTextButton)
        NSLayoutConstraint.activate([
            birthdayTextButton.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 10),
            birthdayTextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            birthdayTextButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    private func setupBirthdayText() {
        dateOfBirthTextField.text = "01.01.2022"
        dateOfBirthTextField.textColor = UIColor(named: "textColor")
        dateOfBirthTextField.backgroundColor = UIColor.background
        dateOfBirthTextField.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        dateOfBirthTextField.layer.borderColor = borderColor.cgColor
        dateOfBirthTextField.layer.borderWidth = 1
        dateOfBirthTextField.layer.cornerRadius = 8
        dateOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateOfBirthTextField)
        NSLayoutConstraint.activate([
            dateOfBirthTextField.topAnchor.constraint(equalTo: birthdayTextButton.bottomAnchor, constant: 10),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func setupGenderTextButton() {
        genderTextButton.setTitle("Пол", for: .normal)
        genderTextButton.contentHorizontalAlignment = .left
        genderTextButton.backgroundColor = .background
        genderTextButton.setTitleColor(UIColor(named: "colorBorderField"), for: .normal)
        genderTextButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        genderTextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderTextButton)
        NSLayoutConstraint.activate([
            genderTextButton.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: 10),
            genderTextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            genderTextButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    private func setupGenderSelectButton(){
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
        genderStack.layer.borderColor = borderColor.cgColor
        genderStack.layer.borderWidth = 1
        genderStack.layer.cornerRadius = 8
        genderStack.clipsToBounds = true
        
        genderStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderStack)
        
        NSLayoutConstraint.activate([
            genderStack.topAnchor.constraint(equalTo: genderTextButton.bottomAnchor, constant: 10),
            genderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genderStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            genderStack.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    private func setupLogoutButton(){
        logoutButton.setTitle("Выйти из аккаунта", for: .normal)
        logoutButton.backgroundColor = .background
        logoutButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        logoutButton.layer.borderColor = UIColor.background.cgColor
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.cornerRadius = 4
        logoutButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}

struct UserProfile: Codable {
    let id: String
    let nickName: String
    let email: String
    let avatarLink: String?
    let name: String
    let birthDate: String
    let gender: Int
}
