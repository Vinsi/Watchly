//
//  SearchResultsResponse.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//




// MARK: - SearchResultsResponse
struct SearchResultsResponse: Codable {
    let page: Int
    let results: [MovieSearchResult]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieSearchResult
struct MovieSearchResult: Codable, Identifiable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let releaseDate: String?
    let posterPath: TMDBImage?
    let backdropPath: TMDBImage?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let genreIDs: [Int]
    let originalLanguage: String
    let adult: Bool
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity, adult, video
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIDs = "genre_ids"
        case originalLanguage = "original_language"
    }
}
