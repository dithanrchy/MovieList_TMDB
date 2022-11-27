//
//  APICaller.swift
//  MovieList
//
//  Created by Ditha Nurcahya Avianty on 25/11/22.
//

import Foundation

struct Constants {
    static let baseURL: String = "https://api.themoviedb.org"
    // API_KEY = "bc82420486812909498ed747e9c4d36f"
    static let API_KEY: String = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    // YOUTUBE_API_KEY = "AIzaSyB5YrjNANveiOIIFn4X3m-VdApoO7pcJT4"
    static let youtubeAPI_KEY: String = ProcessInfo.processInfo.environment["YOUTUBE_API_KEY"] ?? ""
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()

    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/now_playing?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func getMovie(with query: String, completion: @escaping (Result<VideoTrailer, Error>) -> Void) {

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_KEY)") else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items?[0] ?? VideoTrailer(id: IdElement(kind: "bla", videoId: "s"))))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()

    }

    func getMovieReview(with movieId: Int, completion: @escaping (Result<[Review], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(movieId)/reviews?api_key=\(Constants.API_KEY)") else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}

            do {
                let results = try JSONDecoder().decode(ReviewsResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()

    }

}
