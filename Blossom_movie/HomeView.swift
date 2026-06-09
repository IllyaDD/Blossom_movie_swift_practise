//
//  HomeView.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import SwiftUI

struct HomeView: View {
    let viewModel = ViewModel()
    @State private var titleDeailPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $titleDeailPath) {
            GeometryReader { geo in
                ScrollView {
                    switch viewModel.homeStatus {
                    case .notStatted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string: viewModel.heroTiitle.posterPath ?? "")){ image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay{
                                        LinearGradient(
                                            stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.85)
                            HStack{
                                Button{
                                    titleDeailPath.append(viewModel.heroTiitle)
                                }label: {
                                    Text(Constants.playString)
                                        .ghostButton()
                                }
                                
                                Button{
                                    
                                }label: {
                                    Text(Constants.downloadString)
                                        .ghostButton()
                                    
                                }
                            }
                            HorizontallListView(header: Constants.trendingMovieString, titles: viewModel.trendingMovies)
                            {title in titleDeailPath.append(title)}
                            HorizontallListView(header: Constants.trendingTVString, titles: viewModel.trendingTV)
                            {title in titleDeailPath.append(title)}
                            
                            HorizontallListView(header: Constants.topRatedMovieString, titles: viewModel.topRatedTV)
                            {title in titleDeailPath.append(title)}
                            
                            HorizontallListView(header: Constants.topRatedTVString, titles: viewModel.topRatedTV)
                            {title in titleDeailPath.append(title)}
                        }
                    case .failed(let error):
                        Text(verbatim: "Error: \(error)")
                    }
                }
                .task {
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self){title in TitleDetailView(title:title)
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
