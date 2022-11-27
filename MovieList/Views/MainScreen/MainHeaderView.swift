//
//  MainHeaderView.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import UIKit
import SDWebImage

class MainHeaderView: UIView {

    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        addGradient()
        applyConstraint()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: String) {
        guard let url = URL(string: "\(Constants.imageURL)\(model)") else {return}

        headerImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        headerImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
    }
}

extension MainHeaderView {
    private func applyConstraint() {
        headerImageView.setTopAnchorConstraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
    }
}
