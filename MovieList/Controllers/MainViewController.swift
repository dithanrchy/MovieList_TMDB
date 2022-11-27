//
//  MainViewController.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import UIKit

enum Sections: Int {
    case TopRatedMoviews = 0
    case UpcomingMoviews = 1
    case NowPlayingMovies = 2
    case PopularMovies = 3
}

class MainViewController: UIViewController {

    private var headerView: MainHeaderView?

    let sectionTitles: [String] = ["Top rated movies", "Upcoming movies", "Now playing movies", "Popular movies"]

    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.id)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(homeTable)
        homeTable.delegate = self
        homeTable.dataSource = self

        configureNavbar()

        headerView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeTable.tableHeaderView = headerView

        configureMainHeaderView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTable.frame = view.bounds
    }

    private func configureMainHeaderView() {

        APICaller.shared.getPopularMovies { results in
            switch results {
            case .success(let movies):
                DispatchQueue.main.async {
                    let i = Int.random(in: 0...movies.count - 1)
                    self.headerView?.configure(with: movies[i].posterPath ?? "")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func configureNavbar() {
        var image = UIImage(named: "tmdbLogo" )
        image = image?.withRenderingMode(.alwaysOriginal).resizeTo(size: CGSize(width: 40, height: 30))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.black
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.id, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }


        switch indexPath.section {
        case Sections.TopRatedMoviews.rawValue:
            APICaller.shared.getTopRatedMovies { results in
                switch results {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.UpcomingMoviews.rawValue:
            APICaller.shared.getUpcomingMovies { results in
                switch results {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.NowPlayingMovies.rawValue:
            APICaller.shared.getNowPlayingMovies { results in
                switch results {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.PopularMovies.rawValue:
            APICaller.shared.getPopularMovies { results in
                switch results {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return UITableViewCell()
        }

        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeWords()
    }
}

extension MainViewController: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MovieInfoViewModel) {
        DispatchQueue.main.async { 
            let vc = MovieInfoViewController()

            APICaller.shared.getMovieReview(with: viewModel.id) { results in
                switch results {
                case .success(let data):
                    vc.reviewData = data
                case .failure(let error):
                    print(error)
                }
            }

            vc.movieInfoData = viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

