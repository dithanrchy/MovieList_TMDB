//
//  MovieInfoTableViewCell.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import UIKit
import SDWebImage

class MovieInfoTableViewCell: UITableViewCell {

    static let id = "MovieInfoTableViewCell"

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "tmdbLogo")
        imageView.setHeightAnchorConstraint(equalToConstant: 40)
        imageView.setWidthAnchorConstraint(equalToConstant: 40)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A review by MSB"
        return label
    }()

    private let titleDescLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Written by MSB on 19 October 2022"
        return label
    }()

    private let ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.setHeightAnchorConstraint(equalToConstant: 15)
        imageView.setWidthAnchorConstraint(equalToConstant: 15)
        return imageView
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5.0"
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "With a horrid script, lackluster performances, and a waste of potentially awesome characters, Black Adam is an explosive, $195 million, anti-heroic dud. The DCEU is about to get way more convoluted and underwhelming than ever before if this is the future of live action DC films."
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        setupReadMore()
    }

    public func configure(with model: ReviewViewModel) {
        titleLabel.text = "A review by \(model.authorName)"
        titleDescLabel.text = "Written by \(model.authorName) on \(model.createdAt)"
        ratingLabel.text = " \(model.rating ?? 0.0) "
        contentLabel.text = model.content

        guard var imagePath = model.userProfileImagePath else {return}
        if imagePath.prefix(9) == "/https://" {
            imagePath.removeFirst(1)
        } else {
            imagePath = Constants.imageURL+imagePath
        }

        let url = URL(string: "\(imagePath)")

        userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "person.fill"),
            options: .progressiveLoad,
            completed: nil
        )
    }
}

extension MovieInfoTableViewCell {
    private func setupReadMore() {
        guard contentLabel.text != nil else {return}
        let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 11.0)
        let readmoreFontColor = UIColor.blue
        DispatchQueue.main.async {
            self.contentLabel.addTrailing(with: "... ", moreText: "Read More", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
        }
    }

    private func setupLayout() {

        let stackRating = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        stackRating.axis = .horizontal
        stackRating.distribution = .equalSpacing
        stackRating.spacing = 5
        stackRating.backgroundColor = .black
        stackRating.layer.cornerRadius = 5
        stackRating.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackRating.isLayoutMarginsRelativeArrangement = true
        stackRating.translatesAutoresizingMaskIntoConstraints = false

        let stackTitleRating = UIStackView(arrangedSubviews: [titleLabel, stackRating])
        stackTitleRating.axis = .horizontal
        stackTitleRating.distribution = .equalSpacing
        stackTitleRating.spacing = 5
        stackTitleRating.alignment = .center
        stackTitleRating.translatesAutoresizingMaskIntoConstraints = false


        let stackTitle = UIStackView(arrangedSubviews: [stackTitleRating, titleDescLabel])
        stackTitle.axis = .vertical
        stackTitle.translatesAutoresizingMaskIntoConstraints = false

        let stackReviewTitle = UIStackView(arrangedSubviews: [userImageView, stackTitle])
        stackReviewTitle.axis = .horizontal
        stackReviewTitle.distribution = .fill
        stackReviewTitle.spacing = 5
        stackReviewTitle.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackReviewTitle)
        stackReviewTitle.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackReviewTitle.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        stackReviewTitle.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)

        addSubview(contentLabel)
        contentLabel.setTopAnchorConstraint(equalTo: stackReviewTitle.bottomAnchor, constant: 10)
        contentLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 15)
        contentLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -15)
    }
}
