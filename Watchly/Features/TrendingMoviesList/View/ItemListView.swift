//
//  ItemListView.swift
//  Watchly
//
//  Created by Vinsi on 31/05/2025.
//
import SwiftUI
import TMDBCore

struct DeviceLayout {
    let iphonePortrait = 2
    let iphoneLandscape = 4
    let ipadportrait = 4
    let ipadLandscape = 6
}

struct ItemListView: View {
    let movies: [any ListViewDataType]
    var onTap: ((ListViewDataType) -> Void)?
    var onAppear5thLastElement: (() -> Void)?
    private let width = (UIScreen.main.bounds.width - (3 * 8)) * 0.5
    @ViewBuilder
    private func cell(_ movie: ListViewDataType) -> some View {
        MovieBoxView(
            posterURL: movie.posterImagePath?.getImageURL(size: .w185),
            title: movie.title,
            releaseDate: movie.releaseDate,
            rating: movie.voteAverage * 10,
            width: width * 0.99
        )
    }

    var body: some View {
        ScrollView {
            var items: [GridItem] {

                [GridItem(.fixed(width), spacing: 8),
                 GridItem(.fixed(width), spacing: 8)]
            }

            LazyVGrid(columns: items, spacing: 8) {
                ForEach(movies.indices, id: \.self) { index in
                    let movie = movies[index]
                    cell(movie)

                        .onAppear {
                            guard movies.lastNthItem(is: movie, nthIndex: 5) else {
                                return
                            }
                            onAppear5thLastElement?()
                        }
                        .onTapGesture {
                            onTap?(movie)
                        }
                }
            }
            .padding(8)
        }
    }
}

#Preview {
    ItemListView(movies: [Movie.mock(), Movie.mock(id: 2)])
        .frame(width: 160)
        .environmentObject(ThemeManager())
}
