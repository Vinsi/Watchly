//
//  TrendingMovieListServiceType.swift
//
//
//  Created by Vinsi.
//

import Foundation
import TMDBCore

/// 🐱 **Protocol for Fetching Trending Movies**
/// - Defines a contract for retrieving a list of movies.
/// - Supports pagination with `page`` parameters.
///

protocol TrendingMovieListServiceType {
    /// Fetches all trending movies
    /// - Parameters:
    ///   - page: The current page number for pagination.
    /// - Returns: An array of `Movies` objects.
    /// - Throws: An error if the network request fails.
    func getAll(page: Int, canUseCache: Bool) async throws -> TrendingMoviesResponse
}

struct TrendingMovieListServiceImpl: TrendingMovieListServiceType {
    let baseURLProvider: BaseURLProvider
    let tokenProvider: TokenProvider
    var network: NetworkProcesserType
    var cacheFacilitator: EndPointCacheFaciltator<TrendingMoviesEndPoint>
    let language: LanguageManager

    func getAll(page: Int, canUseCache: Bool) async throws -> TrendingMoviesResponse {
        let endPoint = TrendingMoviesEndPoint(
            baseURL: baseURLProvider.baseURL,
            token: tokenProvider.token,
            page: page,
            language: language.selectedLanguage.tmdbLang
        )
        if canUseCache {
            return try await cacheFacilitator.executeWithCache(endPoint: endPoint, network: network)
        } else {
            return try await cacheFacilitator.executeDirectlyAndSaveCache(endPoint: endPoint, network: network)
        }
    }
}
