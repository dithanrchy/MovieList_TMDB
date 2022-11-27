//
//  MovieInfoViewController.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import UIKit

class MovieInfoViewController: UIViewController {

    var movieInfoData: MovieInfoViewModel?
    var reviewData = [Review]()

    private let movieInfoTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoTableViewCell.id)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        view.backgroundColor = UIColor.systemBackground
        setupTableView()
        movieInfoTable.delegate = self
        movieInfoTable.dataSource = self

        guard let movieInfoData = movieInfoData else {
            return
        }

        let headerView = MovieInfoHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 520))
        headerView.configure(with: movieInfoData)
        movieInfoTable.tableHeaderView = headerView
    }
}

extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewData.count > 0 ? reviewData.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if reviewData.count == 0 {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .systemGray
            cell.textLabel?.text = "There are no review, yet :( \nBe the first to share your thoughts!"
            cell.selectionStyle = .none
            movieInfoTable.separatorStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.id, for: indexPath) as? MovieInfoTableViewCell else { return UITableViewCell() }

            cell.configure(with:
                            ReviewViewModel(
                                userProfileImagePath: reviewData[indexPath.row].authorDetails.avatarPath,
                                authorName: reviewData[indexPath.row].author,
                                createdAt: reviewData[indexPath.row].createdAt.formatTodMMMyyy(),
                                content: reviewData[indexPath.row].content,
                                rating: reviewData[indexPath.row].authorDetails.rating,
                                movieData: movieInfoData
                            )
            )
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reviewData.count > 0 {
            let vc = ReviewDetailViewController()
            vc.configure(with:
                            ReviewViewModel(
                                userProfileImagePath: reviewData[indexPath.row].authorDetails.avatarPath,
                                authorName: reviewData[indexPath.row].author,
                                createdAt: reviewData[indexPath.row].createdAt.formatTodMMMyyy(),
                                content: reviewData[indexPath.row].content,
                                rating: reviewData[indexPath.row].authorDetails.rating,
                                movieData: movieInfoData
                            )
            )
            self.present(vc, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension MovieInfoViewController {
    private func setupTableView() {
        view.addSubview(movieInfoTable)
        movieInfoTable.translatesAutoresizingMaskIntoConstraints = false
        movieInfoTable.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        movieInfoTable.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        movieInfoTable.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        movieInfoTable.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
