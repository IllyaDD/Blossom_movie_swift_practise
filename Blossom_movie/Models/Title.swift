//
//  Title.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

 import SwiftData


struct TMDBAPIObject: Decodable{
    var results: [Title] = []
}
@Model
class Title: Decodable, Identifiable, Hashable{
    @Attribute(.unique) var id:Int? = nil
    var title:String? = nil
    var name:String? = nil
    var overview:String? = nil
    var posterPath:String? = nil
    
    
    init(id: Int? = nil, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case name
        case overview
        case posterPath
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)

    }
    
    static var previewTitles = [
        Title(id: 1, title: "BeetleJuice", name: "Send help", overview: "A movie about women", posterPath: Constants.testTittleUrl),
        Title(id: 2, title: "Netflix", name: "Pulp Fiction", overview: "A movie about Pulp Fiction", posterPath: Constants.testTittleUrl2),
        Title(id: 3, title: "Forsage", name: "Forsage 10", overview: "A moive about the cars", posterPath: Constants.testTittleUrl3)
    ]
}
