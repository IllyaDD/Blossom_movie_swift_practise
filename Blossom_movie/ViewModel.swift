//
//  ViewModel.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 17.05.2026.
//

import Foundation


@Observable
class ViewModel{
    enum FetchStatus{
        case notStatted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    private(set) var homeStatus: FetchStatus = .notStatted
    private(set) var videoIdStatus: FetchStatus = .notStatted
    private(set) var upcomingStatus: FetchStatus = .notStatted

    
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    var upcomingMovies: [Title] = []
    var heroTiitle = Title.previewTitles[0]
    var videoId = ""
    func getTitles() async{
        homeStatus = .fetching
        if trendingMovies.isEmpty{
            
        
        
        do{
            async let tMovies = dataFetcher.fetchTitles(for: "movie", by: "trending")
            async let tTV = dataFetcher.fetchTitles(for: "tv", by: "trending")
            async let tRMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
            async let tRTV = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
            
            trendingMovies = try await tMovies
            trendingTV = try await tTV
            topRatedMovies = try await tRMovies
            topRatedTV = try await tRTV
            
            if let title = trendingMovies.randomElement(){
                heroTiitle = title
            }
            homeStatus = .fetching
        }catch{
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
        }else{
            homeStatus = .success
        }
    }
    
    
    func getVideoId(for title:String) async{
        videoIdStatus = .fetching
        do{
            videoId = try await dataFetcher.fetchVideoID(for: title)
            videoIdStatus = .success
        }catch{
            print(error)
            videoIdStatus = .failed(underlyingError: error)
        }
    }
    func getUpcomingMovies() async{
        upcomingStatus = .fetching
        
        
        do{
            upcomingMovies = try await dataFetcher.fetchTitles(for: "movie", by: "upcoming")
            upcomingStatus = .success
        }catch{
            print(error)
            upcomingStatus = .failed(underlyingError: error)
        }
    }
}
