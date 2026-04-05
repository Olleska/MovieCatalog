//
//  CollectionDetailsViewController.swift
//  Movie
//
//  Created by Олеся Лыжина on 23.01.2026.
//

import UIKit

final class CollectionDetailsViewController: UIViewController {
    
    private let collection: MovieCollection
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let editButton = UIButton()
    
    init(collection: MovieCollection) {
        self.collection = collection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupUI()
    }
    
    private func setupUI() {
        setupBackButton()
        setupTitleLabel()
        setupEditButton()
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = collection.name
        titleLabel.textColor = UIColor(named: "baseColor")
        titleLabel.font = UIFont(name: "SFProText-Bold", size: 17)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 10)
        ])
    }
    
    private func setupEditButton() {
        editButton.setImage(UIImage(named: "editIcon"), for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapEditButton() {
        let changeVC = ChangeCollectionViewController(collection: collection)
        navigationController?.pushViewController(changeVC, animated: true)
    }
}
