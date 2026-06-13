//
//  Title.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

 import Foundation

struct TMDBAPIObject: Decodable{
    var results: [Title] = []
}

struct Title: Decodable, Identifiable, Hashable{
    var id:Int? = nil
    var title:String? = nil
    var name:String? = nil
    var overview:String? = nil
    var posterPath:String? = nil
    
    static var previewTitles = [
        Title(id: 1, title: "BeetleJuice", name: "Send help", overview: "A movie about women", posterPath: Constants.testTittleUrl),
        Title(id: 2, title: "Netflix", name: "Pulp Fiction", overview: "A movie about Pulp Fiction", posterPath: Constants.testTittleUrl2),
        Title(id: 3, title: "Forsage", name: "Forsage 10", overview: "A moive about the cars", posterPath: Constants.testTittleUrl3)
    ]
}
