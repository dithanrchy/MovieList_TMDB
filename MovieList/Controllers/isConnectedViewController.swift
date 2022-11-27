//
//  isConnectedViewController.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 27/11/22.
//

import UIKit
import Network

class isConnectedViewController: UIViewController {

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setLayout()
        monitorNetwork()
    }

    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
//                    self.statusLabel.text = "Internet Connected"
                    self.navigationController?.pushViewController(MainViewController(), animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.statusLabel.text = "No Internet :( \nPlease connect to the internet"
                }
            }
        }

        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }

    private func setLayout() {
        view.addSubview(statusLabel)
        statusLabel.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        statusLabel.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }
}
