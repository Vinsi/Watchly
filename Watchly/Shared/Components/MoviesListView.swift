//
//  MoviesListView.swift
//
//
//  Created by Vinsi.
//
import SwiftUI
import TMDBCore

struct MoviesListView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var themeManager: ThemeManager
    let movies: [any ListViewDataType]
    var onTap: ((ListViewDataType) -> Void)?
    var onAppear5thLastElement: (() -> Void)?
    var body: some View {
        List(movies, id: \.movieID) { movie in
            MovieCardView(
                viewData: movie,
                theme: themeManager.currentTheme
            )
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
        .listRowSeparatorTint(.clear)
        .listStyle(PlainListStyle())
    }
}

#Preview {
    MoviesListView(movies: [Movie.mock(), Movie.mock(id: 2)])
        .environmentObject(AppEnvironment.shared)
        .environmentObject(Router())
        .environmentObject(ThemeManager())
}

extension [any ListViewDataType] {
    func lastNthItem(is object: Element, nthIndex: Int) -> Bool {
        suffix(nthIndex).first?.movieID == object.movieID
    }
}
