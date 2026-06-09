//
//  TitleDetailView.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 01.06.2026.
//

import SwiftUI

struct TitleDetailView: View {
    let title:Title
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                LazyVStack(alignment: .leading){
                    YoutubePlayer(videoID: "9bZkp7q19f0")
                        .aspectRatio(1.3, contentMode: .fit)
                    Text((title.name ?? title.title) ?? "")
                        .bold()
                        .font(.title2)
                    
                    Text(title.overview ?? "")
                        .padding(5)
                }
            }
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
