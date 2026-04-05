//
//  CreateCollectionScreen.swift
//  Movie
//
//  Created by Олеся Лыжина on 08.11.2025.
//

import UIKit

final class CreateCollectionScreen: UIViewController, IconSelectionDelegate {
    private let collectionCreateText = UIButton()
    private let backButton = UIButton()
    private let nameCollectionTextField = UITextField()
    private let chooseIconButton = UIButton()
    private let iconImageView = UIImageView()
    private let saveButton = UIButton()
    private let containerView = UIView()
    private var selectedIconName = "1"
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init has not been realized yet")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setup()
    }
    private func setup() {
        setupCollectionCreateText()
        setupBackButton()
        setupCollectionNameTextField()
        setupChooseIcon()
        setupIconImageView()
        setupSaveButton()
    }
    func didSelectIcon(iconName: String) {
        self.selectedIconName = iconName
        self.iconImageView.image = UIImage(named: iconName)
    }
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.contentHorizontalAlignment = .left
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 20),
        ])
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    @objc private func didTapBackButton() {
        print("кнопка нажата!")
        navigationController?.popViewController(animated: true)
    }
    private func setupCollectionCreateText() {
        collectionCreateText.setTitle("Создать коллекцию", for: .normal)
        collectionCreateText.contentHorizontalAlignment = .left
        collectionCreateText.backgroundColor = .background
        collectionCreateText.setTitleColor(UIColor(named: "textColorWithoutText"), for: .normal)
        collectionCreateText.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        collectionCreateText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionCreateText)
        NSLayoutConstraint.activate([
            collectionCreateText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionCreateText.heightAnchor.constraint(equalToConstant: 16),
            collectionCreateText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    private func setupCollectionNameTextField() {
        nameCollectionTextField.attributedPlaceholder = NSAttributedString(
            string: "Название",
            attributes: [
                .foregroundColor: UIColor(named: "grayA8")!,
                .font: UIFont(name: "SFProText-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        nameCollectionTextField.textColor = UIColor(named: "baseColor")
        nameCollectionTextField.backgroundColor = UIColor.background
        nameCollectionTextField.layer.borderColor = UIColor(named: "gray48")?.cgColor
        nameCollectionTextField.layer.borderWidth = 1
        nameCollectionTextField.layer.cornerRadius = 4
        nameCollectionTextField.font = UIFont(name: "SFProText-Regular", size: 14)
        nameCollectionTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        nameCollectionTextField.leftViewMode = .always
        nameCollectionTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameCollectionTextField)
        NSLayoutConstraint.activate([
            nameCollectionTextField.topAnchor.constraint(equalTo: collectionCreateText.bottomAnchor, constant: 32),
            nameCollectionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameCollectionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameCollectionTextField.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    private func setupChooseIcon(){
        chooseIconButton.setTitle("Выбрать иконку", for: .normal)
        chooseIconButton.layer.borderWidth = 1
        chooseIconButton.layer.cornerRadius = 4
        chooseIconButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
        chooseIconButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        chooseIconButton.layer.borderColor = UIColor(named:"grayA8")!.cgColor
        chooseIconButton.backgroundColor = .background
        chooseIconButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseIconButton)
        NSLayoutConstraint.activate([
            chooseIconButton.topAnchor.constraint(equalTo: nameCollectionTextField.bottomAnchor, constant: 32),
            chooseIconButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 112),
            chooseIconButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            chooseIconButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        chooseIconButton.addTarget(self, action: #selector(didTapChooseCollectionButton), for: .touchUpInside)
    }
    @objc private func didTapChooseCollectionButton() {
        let iconSelectionVC = IconSelectionViewController()
        iconSelectionVC.delegate = self
        if let sheet = iconSelectionVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(iconSelectionVC, animated: true)
    }
    private func setupIconImageView(){
        containerView.backgroundColor = UIColor(named: "textColor")
        containerView.layer.cornerRadius = 36
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        iconImageView.image = UIImage(named: "1")
        iconImageView.contentMode = .scaleAspectFit
        containerView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: nameCollectionTextField.bottomAnchor, constant: 15),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.heightAnchor.constraint(equalToConstant: 72),
            containerView.widthAnchor.constraint(equalToConstant: 72),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    private func setupSaveButton(){
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 4
        saveButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
        saveButton.setTitleColor(UIColor(named: "baseColor"), for: .normal)
        saveButton.backgroundColor = .text
        saveButton.layer.borderColor = UIColor(named:"textColor")!.cgColor
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: chooseIconButton.bottomAnchor, constant: 56),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    @objc func didTapSaveButton() {
        guard let name = nameCollectionTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("название коллекции пустое")
            return
        }
        let newCollectionVC = MovieCollection(id: UUID(), name: name, iconName: selectedIconName)
        CollectionManager.shared.saveCollection(newCollectionVC)
        navigationController?.popViewController(animated: false)
    }
}
