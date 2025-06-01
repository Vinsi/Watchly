//
//  MovieGenreListServiceType.swift
//  Watchly
//
//  Created by Vinsi on 29/05/2025.
//
import TMDBCore

protocol MovieGenreListServiceType {
    /// Fetches all trending movies
    /// - Parameters:
    ///   - page: The current page number for pagination.
    /// - Returns: An array of `MoviesGenres` objects.
    /// - Throws: An error if the network request fails.
    func getAll() async throws -> GenreListResponse
}

struct MovieGenreListServiceImpl: MovieGenreListServiceType {
    let baseURLProvider: BaseURLProvider
    let tokenProvider: TokenProvider
    var network: NetworkProcesserType

    func getAll() async throws -> GenreListResponse {
        let endPoint = MovieGenreEndpoint(baseURL: baseURLProvider.baseURL, token: tokenProvider.token)
        return try await network.request(from: endPoint)
    }
}
