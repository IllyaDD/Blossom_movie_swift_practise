//
//  DataFetcher.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 14.05.2026.
//

import Foundation

struct DataFetcher{

    let tmdbBaseURL = APIConfig.shared?.tmdbBaseUrl
    let tmdbAPIKey = APIConfig.shared?.tmdbApiKey
    let youtubeSearchURL = APIConfig.shared?.yotubeSearchURL
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIkey

    //https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY&language=en-US&page=1

    func fetchTitles(for media:String, by type:String) async throws -> [Title]{
        let fetchTitlesURL = try buildURL(media: media, type: type)

        guard let fetchTitlesURL = fetchTitlesURL else{
            throw NetworkError.urlBuildFailed
        }

        print(fetchTitlesURL)

        let (data,urlResponse) = try await URLSession.shared.data(from: fetchTitlesURL)

        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        Constants.addPosterPath(to: &titles)
        return titles
    }

    private func buildURL(media:String, type:String) throws -> URL?{
        guard let baseURL = tmdbBaseURL else{
            throw NetworkError.missConfig
        }
        guard let apiKey = tmdbAPIKey else{
            throw NetworkError.missConfig
        }

        var path:String

        if type == "trending"{
            path = "3/trending/\(media)/day"
        } else if type == "top_rated"{
            path = "3/\(media)/top_rated"
        } else{
            throw NetworkError.urlBuildFailed
        }

        guard let url = URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else{
            throw NetworkError.urlBuildFailed
        }

        return url
    }
}
