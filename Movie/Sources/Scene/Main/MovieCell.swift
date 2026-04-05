//
//  MovieCell.swift
//  Movie
//
//  Created by Олеся Лыжина on 21.01.2026.
//
import UIKit

final class MovieCell: UITableViewCell {

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    private let countryLabel = UILabel()
    private let genresLabel = UILabel()
    private let ratingView = UIView()
    private let ratingLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMovies()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupMovies() {
        contentView.backgroundColor = .background
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .green

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 20)
        titleLabel.textColor = UIColor(named: "baseColor")
        titleLabel.numberOfLines = 2

        contentView.addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        yearLabel.textColor = UIColor(named: "baseColor")

        contentView.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        countryLabel.textColor = UIColor(named: "baseColor")
        //countryLabel.numberOfLines = 2

        contentView.addSubview(genresLabel)
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        genresLabel.textColor = UIColor(named: "baseColor")
        genresLabel.numberOfLines = 2
        
        contentView.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.layer.cornerRadius = 15
        
        contentView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        ratingLabel.textColor = UIColor(named: "baseColor")

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 144),

            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            countryLabel.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 0),
            countryLabel.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            //countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //countryLabel.heightAnchor.constraint(equalToConstant: 30),

            genresLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 0),
            genresLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            ratingView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            ratingView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            ratingView.heightAnchor.constraint(equalToConstant: 28),
            ratingView.widthAnchor.constraint(equalToConstant: 56),
                        
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
        ])
    }
    func configure(with movie: MainViewModel.MovieModel) {
        titleLabel.text = movie.title
        yearLabel.text = "\(movie.year) • "
        countryLabel.text = "\(movie.country)"
        genresLabel.text = "\(movie.genre.joined(separator: ", "))"

        if let url = URL(string: movie.poster) {
            posterImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "film")
            )
        }
        let finalRating = movie.rating.reduce(0, +) / Double(movie.rating.count)
        ratingLabel.text = String(format: "%.1f", finalRating)
        ratingView.backgroundColor = getRatingColor(finalRating)
    }
    private func getRatingColor(_ rating: Double) -> UIColor {
        switch rating {
            case 0.0..<1.5:
                return UIColor(named: "1.0")!
            case 1.5..<2.5:
                return UIColor(named: "2.0")!
            case 2.5..<3.5:
                return UIColor(named: "3.0")!
            case 3.5..<4.5:
                return UIColor(named: "4.0")!
            case 4.5..<5.5:
                return UIColor(named: "5.0")!
            case 5.5..<6.5:
                return UIColor(named: "6.0")!
            case 6.5..<7.5:
                return UIColor(named: "7.0")!
            case 7.5..<8.5:
                return UIColor(named: "8.0")!
            default:
                return UIColor(named: "9.0")!
        }
    }
}
