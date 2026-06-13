//
//  ContentView.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 12.05.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        TabView{
            Tab(Constants.homeString, systemImage: Constants.homeIconString){
                HomeView(viewModel: viewModel)
            }
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString){
                UpcomigView(viewModel: viewModel)
                
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString){
                SearchView()
                
            }
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString){
                    DownloadView()
                }
            }
        }
    }


#Preview {
    ContentView()
}
