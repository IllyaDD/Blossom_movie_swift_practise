//
//  APIConfig.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import Foundation



struct APIConfig: Decodable{
    let tmdbBaseUrl:String
    let tmdbApiKey:String
    let youtubeBaseURL:String
    let youtubeAPIkey:String
    let yotubeSearchURL:String
    
    static let shared:APIConfig? = {
        do {
            return try loadConfig()
        }catch{
            print("Failed to load API config: \(error.localizedDescription)")
            return nil
        }
            }()
    private static func loadConfig() throws -> APIConfig{
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json")else{
            throw APIConfigError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from:data)
            
        }catch{
            throw APIConfigError.decodingFailed(underlyingError: error)
        }
    }
}
