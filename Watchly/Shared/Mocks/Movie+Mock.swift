//
//  Movie+Mock.swift
//  Watchly
//
//  Created by Vinsi.
//

extension Movie {
    static func mock(
        id: Int = 1,
        title: String = "Mock Movie",
        originalTitle: String = "Mock Original Title",
        overview: String = "This is a mock movie used for testing and preview.",
        posterPath: TMDBImage? = "/mockPoster.jpg",
        backdropPath: TMDBImage? = "/mockBackdrop.jpg",
        mediaType: String? = "movie",
        genreIDs: [Int] = [28, 35],
        releaseDate: String? = "2025-05-28",
        voteAverage: Double = 7.3,
        voteCount: Int = 1240,
        popularity: Double = 88.5,
        adult: Bool = false,
        originalLanguage: String = "en",
        video: Bool = false
    ) -> Movie {
        return Movie(
            id: id,
            title: title,
            originalTitle: originalTitle,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            mediaType: mediaType,
            genreIDs: genreIDs,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount,
            popularity: popularity,
            adult: adult,
            originalLanguage: originalLanguage,
            video: video
        )
    }
}
