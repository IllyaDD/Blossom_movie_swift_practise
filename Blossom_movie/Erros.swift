//
//  Erros.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not found."
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data from API configuration file: \(error.localizedDescription)."
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API configuration: \(error.localizedDescription)."
        }
    }
}



enum NetworkError: Error, LocalizedError{
    case badURLResponse(underlyingError: Error)
    case missConfig
    case urlBuildFailed
    
    var errorDescription: String?{
        switch self{
        case .badURLResponse(underlyingError: let error):
            return "Failed to parse URL response:  \(error.localizedDescription)."
        case .missConfig:
            return "Missing API config"
        case .urlBuildFailed:
            return "Failed to build URL"
        }
        
    }
}
