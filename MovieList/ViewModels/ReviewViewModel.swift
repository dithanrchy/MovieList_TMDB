//
//  ReviewViewModel.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import Foundation

struct ReviewViewModel {
    let userProfileImagePath: String?
    let authorName: String
    let createdAt: String
    let content: String
    let rating: Float?

    let movieData: MovieInfoViewModel?
}
