//
//  UpcomigView.swift
//  Blossom_movie
//
//  Created by Illya Donchenko on 13.06.2026.
//

import SwiftUI

struct UpcomigView: View {
    let viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            GeometryReader{ geo in
                switch viewModel.upcomingStatus {
                case .notStatted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpcomigView()
}
