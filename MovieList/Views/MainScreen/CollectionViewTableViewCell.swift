//
//  CollectionViewTableViewCell.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import SDWebImage
import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MovieInfoViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    static let id = "CollectionViewTableViewCell"

    weak var delegate: CollectionViewTableViewCellDelegate?

    private var movies: [Movie] = [Movie]()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    public func configure(with movies: [Movie]){
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.row].posterPath ?? "")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let movieName = movies[indexPath.row].title

        APICaller.shared.getMovie(with: movieName + " trailer") { result in
            switch result {
            case .success(let videoElement):

                let movie = self.movies[indexPath.row]
                let viewModel = MovieInfoViewModel(id: movie.id, title: movieName, youtubeTrailer: videoElement, titleOverview: movie.overview ?? "", releaseYear: movie.releaseDate.stringToYearDate(), posterImagePath: movie.posterPath ?? nil)
                self.delegate?.CollectionViewTableViewCellDidTapCell(self, viewModel: viewModel)

            case .failure(let error ):
                print(error)
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x
        if position >  (collectionView.contentSize.width-100-scrollView.frame.size.width) {
            self.movies.append(contentsOf: movies)
            collectionView.reloadData()
        }
    }

}
