//
//  YoutubeSearchResponse.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 09.06.2026.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
    
}
