//
//  YoutubeSearchResponse.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoTrailer]?
}

struct VideoTrailer: Codable {
    let id: IdElement
}

struct IdElement: Codable {
    let kind: String
    let videoId: String
}
