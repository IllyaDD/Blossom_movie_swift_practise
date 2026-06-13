//
//  Blossom_movieApp.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import SwiftUI
import SwiftData
@main
struct Blossom_movieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
