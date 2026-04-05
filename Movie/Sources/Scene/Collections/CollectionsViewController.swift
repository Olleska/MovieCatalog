//
//  CollectionsViewController.swift
//  Movie
//
//  Created by Олеся Лыжина on 08.11.2025.
//

import UIKit

final class CollectionsViewController: UIViewController {
    private let tableView = UITableView()
    private var collections: [MovieCollection] = []
    private let nameCollectionButton = UIButton()
    private let addCollectionButton = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadData()
    }
    private func loadData() {
        collections = CollectionManager.shared.loadCollections()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setup()
    }
    private func setup() {
        setupNameLable()
        setupTableView()
        setupAddCollection() 
    }
    @objc private func didTapAddButton() {
        print("кнопка нажата!")
        let collectionVC = CreateCollectionScreen()
        navigationController?.pushViewController(collectionVC, animated: false)
    }
    private func setupAddCollection() {
        addCollectionButton.setImage(UIImage(named: "addCollection"), for: .normal)
        addCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCollectionButton)
        NSLayoutConstraint.activate([
            addCollectionButton.widthAnchor.constraint(equalToConstant: 16),
            addCollectionButton.heightAnchor.constraint(equalToConstant: 16),
            addCollectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addCollectionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        addCollectionButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    private func setupNameLable() {
        nameCollectionButton.setTitle("Коллекции", for: .normal)
        nameCollectionButton.contentHorizontalAlignment = .left
        nameCollectionButton.backgroundColor = .background
        nameCollectionButton.setTitleColor(UIColor(named: "textColorWithoutText"), for: .normal)
        nameCollectionButton.titleLabel?.font = UIFont(name: "SFProText-SemiBold", size: 17)
        nameCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameCollectionButton)
        NSLayoutConstraint.activate([
            nameCollectionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameCollectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameCollectionButton.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    private func setupTableView() {
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: nameCollectionButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(CollectionCell.self, forCellReuseIdentifier: "CollectionCell")
    }
}

extension CollectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return collections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else { return UITableViewCell() }
        let collection = collections[indexPath.row]
        cell.configure(title: collection.name, icon: UIImage(named: collection.iconName) ?? UIImage(), showArrow: true)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCollection = collections[indexPath.row]
        let detailsVC = CollectionDetailsViewController(collection: selectedCollection)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
