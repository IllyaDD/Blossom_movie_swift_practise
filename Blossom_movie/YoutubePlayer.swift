//
//  YoutubePlayer.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 07.06.2026.
//

import SwiftUI
import YouTubePlayerKit


struct YoutubePlayer: View {
    let videoID: String

    var body: some View {
        YouTubePlayerView(
            YouTubePlayer(
                source: .video(id: videoID),
                configuration: .init(
                    allowsInlineMediaPlayback: true
                )
            )
        ) { state in
            switch state {
            case .idle:
                ProgressView()
            case .ready:
                EmptyView()
            case .error(let error):
                Text(verbatim: "Error: \(error)")
            }
        }
    }
}
