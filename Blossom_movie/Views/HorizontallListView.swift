//
//  HorizontallListView.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import SwiftUI

struct HorizontallListView: View {
    let header: String
    let titles: [Title]
    let onSelect: (Title) -> Void
    var body: some View {
        VStack(alignment: .leading){
            Text(header)
                .font(.title)
            
            ScrollView (.horizontal){
                LazyHStack{
                    ForEach(titles){title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){image in image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture {
                            onSelect(title)
                        }
                    }
                }
            }
        }
        .frame(height: 250)
        .padding(10)
    }
}

#Preview {
    HorizontallListView(header: Constants.trendingMovieString, titles: Title.previewTitles){title in }
}
