//
//  MainHeaderView.swift
//  Movie
//
//  Created by Олеся Лыжина on 31.10.2025.
//

import UIKit
import Kingfisher

final class MainHeaderView: UIView {
    struct Config {
        let mainFilmPoster: String
        let films: [String]
    }
    private let imageView = UIImageView()
    private let gradient = CAGradientLayer()
    private let watchButton = UIButton()
    private let titleLabel = UILabel()
    private let favoritesTitle =  UILabel()
    private let favoritesCollection = UIView()
    private var config : Config?
    var onWatchButtonTap: (() -> Void)?
    init () {
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init coder not implemented")
    }
    func configure(with config: Config) {
        guard let urlImage = URL(string: config.mainFilmPoster) else { return }
        imageView.kf.setImage(with: urlImage)
    }
    private func setup() {
        backgroundColor = .background
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
        watchButton.setTitle("Смотреть", for: .normal)
        watchButton.backgroundColor = UIColor(named: "textColor")
        watchButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        watchButton.setTitleColor(.white, for: .normal)
        watchButton.layer.cornerRadius = 4
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(watchButton)
        NSLayoutConstraint.activate([
            watchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            watchButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 293),
            watchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 108),
            watchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -108),
            watchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        watchButton.addTarget(self, action: #selector(didTapWatchButton), for: .touchUpInside)
    }
    
    @objc func didTapWatchButton() {
        onWatchButtonTap?()
    }
}
