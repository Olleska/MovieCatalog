//
//  ChangeCollectionScreen.swift
//  Movie
//
//  Created by Олеся Лыжина on 23.01.2026.
//

import UIKit

final class ChangeCollectionViewController: UIViewController, IconSelectionDelegate {
    private let collection: MovieCollection

    private let collectionCreateText = UIButton()
    private let backButton = UIButton()
    private let nameCollectionTextField = UITextField()
    private let chooseIconButton = UIButton()
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let saveButton = UIButton()
    private let deleteButton = UIButton()
    
    private var selectedIconName: String

    init(collection: MovieCollection) {
        self.collection = collection
        self.selectedIconName = collection.iconName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupUI()
        nameCollectionTextField.text = collection.name
        iconImageView.image = UIImage(named: collection.iconName)
    }

    private func setupUI() {
        setupBackButton()
        setupCollectionCreateText()
        setupCollectionNameTextField()
        setupIconImageView()
        setupChooseIcon()
        setupSaveButton()
        setupDeleteButton()
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupCollectionCreateText() {
        collectionCreateText.setTitle("Изменить коллекцию", for: .normal)
        collectionCreateText.contentHorizontalAlignment = .center
        collectionCreateText.setTitleColor(UIColor(named: "baseColor"), for: .normal)
        collectionCreateText.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        collectionCreateText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionCreateText)
        NSLayoutConstraint.activate([
            collectionCreateText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionCreateText.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
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
            nameCollectionTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupIconImageView() {
        containerView.backgroundColor = UIColor(named: "textColor")
        containerView.layer.cornerRadius = 36
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: nameCollectionTextField.bottomAnchor, constant: 15),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.heightAnchor.constraint(equalToConstant: 72),
            containerView.widthAnchor.constraint(equalToConstant: 72),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupChooseIcon() {
        chooseIconButton.setTitle("Выбрать иконку", for: .normal)
        chooseIconButton.layer.borderWidth = 1
        chooseIconButton.layer.cornerRadius = 4
        chooseIconButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
        chooseIconButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        chooseIconButton.layer.borderColor = UIColor(named:"grayA8")?.cgColor
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

    private func setupDeleteButton() {
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor(named: "grayA8")?.cgColor
        deleteButton.layer.cornerRadius = 4
        deleteButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)!
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }
    @objc func didTapSaveButton() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func didTapDeleteButton() {
        CollectionManager.shared.deleteCollection(id: collection.id)
        navigationController?.popToRootViewController(animated: true)
    }
    func didSelectIcon(iconName: String) {
        self.selectedIconName = iconName
        self.iconImageView.image = UIImage(named: iconName)
    }
}
