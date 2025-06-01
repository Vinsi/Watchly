//
//  MovieDetailsServiceType.swift
//
//
//  Created by Vinsi.
//
import TMDBCore

/// 🐱 **Protocol for Fetching Movies info**
/// - Defines a contract for retrieving Movies
protocol MovieDetailsServiceType {
    /// 📸 **Fetches Movie details  from API**
    /// - Parameter id: The unique identifier of the cat breed.
    /// - Returns: An movie Details` objects.
    /// - Throws: If the network request fails.
    func getDetails(movieID: Int) async throws -> MovieDetails
}

struct MovieDetailsServiceTypeImpl: MovieDetailsServiceType {

    let network: NetworkProcesserType
    let baseURLProvider: BaseURLProvider
    let tokenProvider: TokenProvider
    let cachefacilitator: EndPointCacheFaciltator<MovieDetailEndPoint>

    func getDetails(movieID: Int) async throws -> MovieDetails {
        try await cachefacilitator.executeWithCache(
            endPoint: MovieDetailEndPoint(baseURL: baseURLProvider.baseURL, token: tokenProvider.token, id: movieID),
            network: network
        )
    }
}
