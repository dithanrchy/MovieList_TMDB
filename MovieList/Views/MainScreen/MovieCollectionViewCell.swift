//
//  MovieCollectionViewCell.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import SDWebImage
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let id = "MovieCollectionViewCell"

    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = bounds
    }

    public func configure(with model: String) {
        guard let url = URL(string: "\(Constants.imageURL)\(model)") else {return}

        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        posterImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
    }
}
