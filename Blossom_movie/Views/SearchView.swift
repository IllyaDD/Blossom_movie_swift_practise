//
//  SearchView.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 13.06.2026.
//

import SwiftUI

struct SearchView: View {
    var titles = Title.previewTitles
    @State private var searchByMovies = true
    @State private var searchText: String = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            ScrollView {
                if let error = searchViewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(searchViewModel.searchTitles){title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){
                            image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius:10))
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture {
                            navigationPath.append(title)
                        }
                    }
                }
            }
            .navigationTitle(searchByMovies ? Constants.movieSearchString : Constants.tvSearchString)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        searchByMovies.toggle()
                        
                        Task{
                            await searchViewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
                        }
                        
                    }label: {
                        Image(systemName: searchByMovies ? Constants.movieIconString : Constants.tvIconString)
                    }
                }
            }
            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: searchByMovies ? Constants.moviePlacHolderString : Constants.tvPlacHolderString,)
            
            
            .task(id:searchText){
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled {
                    return
                }
                await searchViewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }
}


#Preview {
    SearchView()
}
