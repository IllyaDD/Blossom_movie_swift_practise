//
//  Constants.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import Foundation
import SwiftUI

struct Constants{
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"
    
    static let playString = "Play"
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    
    static let testTittleUrl = "https://image.tmdb.org/t/p/w500/mjkS2iAgWj3ik1DTjvI15nHZ7yl.jpg"
    static let testTittleUrl2 = "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg"
    static let testTittleUrl3 = "https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"
    
    static let postureURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout[Title]){
        for index in titles.indices{
            if let path = titles[index].posterPath{
                titles[index].posterPath = Constants.postureURLStart + path
            }
        }
    }
}


enum YoutubeURLString:String{
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key = "key"
}



extension Text{
        func ghostButton() -> some View{
            self
                .frame(width: 100, height:50)
                .foregroundStyle(.buttonText)
                .bold()
                .background(){
                    RoundedRectangle(cornerRadius: 20,      style: .continuous)
                        .stroke(.buttonBorder,lineWidth: 5)
            }
        }
    }
