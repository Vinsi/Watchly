//
//  ItemListView.swift
//  Watchly
//
//  Created by Vinsi on 31/05/2025.
//
import SwiftUI
import TMDBCore

enum DeviceLayout: Int {
    case phonePortrait = 2
    case phoneLandscape = 3
    case padPortrait = 4
    case padLandscape = 6

    init(size: UserInterfaceSizeClass, isLandScape: Bool) {

        switch (UIDevice.current.userInterfaceIdiom, size) {
        case (.phone, .compact):
            self = .phonePortrait
        case (.phone, .regular):
            self = .phoneLandscape
        case (.pad, .compact):
            self = .padPortrait
        case (.pad, .regular) where isLandScape:
            self = .padLandscape
        case (.pad, .regular):
            self = .padPortrait
        default:
            self = .phonePortrait
        }
    }

    var columnsCount: Int {
        switch self {
        case .phonePortrait:
            2
        case .phoneLandscape:
            3
        case .padPortrait:
            4
        case .padLandscape:
            6
        }
    }

    func columns(spacing: CGFloat) -> [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnsCount - 1) + [GridItem(.flexible())]
    }
}

struct ItemListView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var orientation: DeviceOrientationObserver
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let movies: [any ListViewDataType]
    var onTap: ((ListViewDataType) -> Void)?
    var onAppear5thLastElement: (() -> Void)?

    @ViewBuilder
    private func cell(_ movie: ListViewDataType) -> some View {
        MovieBoxView(
            posterURL: movie.posterImagePath?.getImageURL(size: .w185),
            title: movie.title,
            releaseDate: movie.releaseDate,
            rating: movie.voteAverage * 10
        )
        .accessibilityLabel("moviebox")
    }

    var columns: [GridItem] {
        DeviceLayout(
            size: horizontalSizeClass ?? .compact,
            isLandScape: orientation.isLandscape
        )
        .columns(
            spacing: themeManager.currentTheme.spacing.small
        )
    }

    var body: some View {
        ScrollView {

            LazyVGrid(columns: columns, spacing: themeManager.currentTheme.spacing.small) {
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
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.purple.opacity(0.2), lineWidth: 1)
//        )
        .padding(.horizontal, themeManager.currentTheme.spacing.small)
        .padding(.bottom, 0)
    }
}

#Preview {
    ItemListView(movies: [Movie.stub(), Movie.stub(id: 2)])
        .frame(width: 160)
        .environmentObject(ThemeManager())
}
