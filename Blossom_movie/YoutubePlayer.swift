//
//  YoutubePlayer.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 07.06.2026.
//

import WebKit
import SwiftUI


struct YoutubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoID: String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL

    func makeUIView(context: Context) -> some UIView {
        webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseUrlString = youtubeBaseURL,
              let baseURL = URL(string: baseUrlString) else {return}
        let fullURL = baseURL.appending(path: videoID)
        webView.load(URLRequest(url: fullURL))
    }

}
