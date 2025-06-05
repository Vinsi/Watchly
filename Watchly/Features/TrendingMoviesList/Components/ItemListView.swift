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
    let ipadportrait = 4
}

struct ItemListView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    let movies: [any ListViewDataType]
    var onTap: ((ListViewDataType) -> Void)?
    var onAppear5thLastElement: (() -> Void)?
    private var width: CGFloat {
        if horizontalSizeClass == .compact {
            return ScreenLayout.gridLength(count: 2, spacing: 8)
        } else {
            return ScreenLayout.gridLength(count: 4, spacing: 8)
        }
    }

    @ViewBuilder
    private func cell(_ movie: ListViewDataType) -> some View {
        MovieBoxView(
            posterURL: movie.posterImagePath?.getImageURL(size: .w185),
            title: movie.title,
            releaseDate: movie.releaseDate,
            rating: movie.voteAverage * 10,
            width: width
        )
        .accessibilityLabel("moviebox")
    }

    var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            return [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible()),
            ]
        } else {
            return [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible()),
            ]
        }
    }

    var body: some View {
        ScrollView {

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(movies, id: \.movieID) { index in
                    let movie = index // movies[index]
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
    ItemListView(movies: [Movie.stub(), Movie.stub(id: 2)])
        .frame(width: 160)
        .environmentObject(ThemeManager())
}
