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

    func fetchTitles(for media:String, by type:String, with title:String? = nil) async throws -> [Title]{
        let fetchTitlesURL = try buildURL(media: media, type: type, searchPhrase: title)

        guard let fetchTitlesURL = fetchTitlesURL else{
            throw NetworkError.urlBuildFailed
        }

        print(fetchTitlesURL)
        var titles = try await fetchAndDecode(url: fetchTitlesURL, type: TMDBAPIObject.self).results
        
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    
    
    
    func fetchVideoID(for title: String) async throws -> String{
        guard let baseSearchURL = youtubeSearchURL else{
            throw NetworkError.missConfig
        }
        guard let searchAPIkey = youtubeAPIKey else{
            throw NetworkError.missConfig
        }
        
        let trailerSearch = title + YoutubeURLString.space.rawValue + YoutubeURLString.trailer.rawValue
        
        
        guard let fetchVideoURL = URL(string: baseSearchURL)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLString.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLString.key.rawValue, value: searchAPIkey)
        ])else{
            throw NetworkError.urlBuildFailed
        }
        print(fetchVideoURL)
        
        return try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
    
    func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T{
        let (data,urlResponse) = try await URLSession.shared.data(from: url)

        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return  try decoder.decode(type, from: data)
    }

    private func buildURL(media:String, type:String, searchPhrase:String? = nil) throws -> URL?{
        guard let baseURL = tmdbBaseURL else{
            throw NetworkError.missConfig
        }
        guard let apiKey = tmdbAPIKey else{
            throw NetworkError.missConfig
        }

        var path:String

        if type == "trending"{
            path = "3/\(type)/\(media)/day"
        } else if type == "top_rated" || type == "upcoming"{
            path = "3/\(media)/\(type)"
        }else if type == "search"{
            path = "3/\(type)/\(media)"
        }else{
            throw NetworkError.urlBuildFailed
        }
        
        
        var urlQueryItems = [
            URLQueryItem(name:"api_key", value: apiKey)
        ]
        
        if let searchPhrase{
            urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase))
        }

        guard let url = URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems) else{
            throw NetworkError.urlBuildFailed
        }

        return url
    }
}
