//
//  MovieInfoHeaderView.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import UIKit
import WebKit
import SDWebImage

class MovieInfoHeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Black Panther"
        return label
    }()

    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022"
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You should watch this, pal!"
        return label
    }()

    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: MovieInfoViewModel) {
        titleLabel.text = model.title
        releaseYearLabel.text = "(\(model.releaseYear))"
        overviewLabel.text = model.titleOverview

        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeTrailer.id.videoId)") else {return}
        webView.load(URLRequest(url: url))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension MovieInfoHeaderView {
    private func setupLayout() {
        addSubview(webView)
        webView.setTopAnchorConstraint(equalTo: safeAreaLayoutGuide.topAnchor)
        webView.setLeadingAnchorConstraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        webView.setTrailingAnchorConstraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        webView.setHeightAnchorConstraint(equalToConstant: 250)

        let stackTitleYear = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        stackTitleYear.axis = .horizontal
        stackTitleYear.distribution = .equalSpacing
        stackTitleYear.spacing = 5
        stackTitleYear.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackTitleYear)
        stackTitleYear.setTopAnchorConstraint(equalTo: webView.bottomAnchor, constant: 20)
        stackTitleYear.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)

        addSubview(overviewLabel)
        overviewLabel.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        overviewLabel.setLeadingAnchorConstraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        overviewLabel.setTrailingAnchorConstraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)

        addSubview(reviewLabel)
        reviewLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        reviewLabel.setBottomAnchorConstraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
    }
}
