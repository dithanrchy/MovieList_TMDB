//
//  ReviewDetailViewController.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 27/11/22.
//

import UIKit
import SDWebImage

class ReviewDetailViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()

    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "A review by MSB"
        return label
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "tmdbLogo")
        imageView.setHeightAnchorConstraint(equalToConstant: 200)
        imageView.setWidthAnchorConstraint(equalToConstant: 140)
        return imageView
    }()

    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022"
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Black Panther"
        return label
    }()

    private let ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.setHeightAnchorConstraint(equalToConstant: 20)
        imageView.setWidthAnchorConstraint(equalToConstant: 20)
        return imageView
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5.0"
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.text = "With a horrid script, lackluster performances, and a waste of potentially awesome characters, Black Adam is an explosive, $195 million, anti-heroic dud. The DCEU is about to get way more convoluted and underwhelming than ever before if this is the future of live action DC films."
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupScrollView()
        setupLayout()
    }

    public func configure(with model: ReviewViewModel) {

        guard let movieData = model.movieData, let posterPath = movieData.posterImagePath else {return}

        userLabel.text = "A review by \(model.authorName)"
        titleLabel.text = movieData.title
        releaseYearLabel.text = "(\(movieData.releaseYear))"
        ratingLabel.text = " \(model.rating ?? 0.0) "
        contentLabel.text = model.content

        guard let url = URL(string: "\(Constants.imageURL)\(posterPath)") else {return}

        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        posterImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
    }
}

extension ReviewDetailViewController {
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        scrollView.setWidthAnchorConstraint(equalTo: view.widthAnchor)
        scrollView.setTopAnchorConstraint(equalTo: view.topAnchor)
        scrollView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)

        contentView.setCenterXAnchorConstraint(equalTo: scrollView.centerXAnchor)
        contentView.setWidthAnchorConstraint(equalTo: scrollView.widthAnchor)
        contentView.setTopAnchorConstraint(equalTo: scrollView.topAnchor)
        contentView.setBottomAnchorConstraint(equalTo: scrollView.bottomAnchor)
    }
    private func setupLayout() {
        contentView.addSubview(userLabel)
        userLabel.setTopAnchorConstraint(equalTo: contentView.topAnchor, constant: 20)
        userLabel.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 20)

        let stackViewTitle = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        stackViewTitle.axis = .horizontal
        stackViewTitle.distribution = .equalSpacing
        stackViewTitle.spacing = 5
        stackViewTitle.translatesAutoresizingMaskIntoConstraints = false

        let stackRating = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        stackRating.axis = .horizontal
        stackRating.distribution = .equalSpacing
        stackRating.spacing = 5
        stackRating.backgroundColor = .black
        stackRating.layer.cornerRadius = 5
        stackRating.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackRating.isLayoutMarginsRelativeArrangement = true
        stackRating.translatesAutoresizingMaskIntoConstraints = false

        let stackViewMovie = UIStackView(arrangedSubviews: [posterImageView, stackViewTitle, stackRating])
        stackViewMovie.axis = .vertical
        stackViewMovie.distribution = .equalSpacing
        stackViewMovie.spacing = 10
        stackViewMovie.alignment = .center
        stackViewMovie.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackViewMovie)
        stackViewMovie.setTopAnchorConstraint(equalTo: userLabel.bottomAnchor, constant: 20)
        stackViewMovie.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        stackViewMovie.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)

        contentView.addSubview(contentLabel)
        contentLabel.setTopAnchorConstraint(equalTo: stackViewMovie.bottomAnchor, constant: 20)
        contentLabel.setLeadingAnchorConstraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        contentLabel.setTrailingAnchorConstraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        contentLabel.setBottomAnchorConstraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15)
    }
}
