//
//  CollectionCell.swift
//  Movie
//
//  Created by Олеся Лыжина on 22.01.2026.
//

import UIKit

final class CollectionCell: UITableViewCell {
    private let iconContainer = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let arrowView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        backgroundColor = .background
        selectionStyle = .none
        
        iconContainer.backgroundColor = UIColor(named: "textColor")
        iconContainer.layer.cornerRadius = 24
        
        iconView.contentMode = .scaleAspectFit
        titleLabel.textColor = UIColor(named: "baseColor")
        titleLabel.font = UIFont(name: "SFProText-Bold", size: 14)
        arrowView.image = UIImage(named: "collectionArrow")
        arrowView.tintColor = UIColor(named:"grayA8")
        
        [iconContainer, titleLabel, arrowView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        iconContainer.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 48),
            iconContainer.heightAnchor.constraint(equalToConstant: 48),

            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 18),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func configure(title: String, icon: UIImage, showArrow: Bool) {
        titleLabel.text = title
        iconView.image = icon
        arrowView.isHidden = !showArrow
    }
}
