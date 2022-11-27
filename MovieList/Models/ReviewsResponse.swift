//
//  UserReview.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import Foundation

// MARK: - UserReview
struct ReviewsResponse: Codable {
    let results: [Review]
}

// MARK: - Review
struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username: String
    let avatarPath: String?
    let rating: Float?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
