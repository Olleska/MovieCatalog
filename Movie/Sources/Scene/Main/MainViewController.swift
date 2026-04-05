//
//  MainScreenViewController.swift
//  Movie
//
//  Created by Олеся Лыжина on 24.10.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let tableView = UITableView (frame: .zero, style: .grouped)
    private let headerView = MainHeaderView()
    private let viewModel = MainViewModel()
    
    private var movies: [MainViewModel.MovieModel] = []
    
    private let cellIdentifier = "MovieCell"
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setup()
        bindToViewModel()
        viewModel.getMovies()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func bindToViewModel(){
        viewModel.onDidLoadMovies = { [weak self] moviesData in
            self?.headerView.configure(with: .init(mainFilmPoster: moviesData.headerImage, films: []))
            self?.movies = moviesData.movies
            self?.tableView.reloadData()
        }
    }
    
    private func setup(){
        setupTableView()
        setupHeaderView()
    }
    private func setupTableView(){
        tableView.backgroundColor = .background
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 144
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    private func setupHeaderView(){
        tableView.tableHeaderView = headerView
        headerView.layoutIfNeeded()
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
        }
        tableView.tableHeaderView = headerView
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell else {
            return  UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row >= movies.count - 3 {
                viewModel.loadNextPage()
            }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .background
            
            let label = UILabel()
            label.text = "Галерея"
            label.textColor = UIColor(named: "textColor")
            label.font = UIFont(name: "IBMPlexSans-Bold", size: 24)

            headerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            return headerView
        }
    
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 36
        }
}
