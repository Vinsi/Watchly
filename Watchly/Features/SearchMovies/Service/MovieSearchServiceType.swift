//
//  MovieSearchServiceType.swift
//
//
//  Created by Vinsi.
//

import TMDBCore

protocol SearchServiceType {
    func search(query: String) async throws -> SearchResultsResponse?
}

struct MovieSearchServiceImpl: SearchServiceType {

    let network: NetworkProcesserType
    let baseURLProvider: BaseURLProvider
    let tokenProvider: TokenProvider
    let cacheFacilitator: EndPointCacheFaciltator<SearchMoviesEndPoint>

    func search(query: String) async throws -> SearchResultsResponse? {
        guard query.isNotEmpty else {
            return nil
        }
        let endPoint = SearchMoviesEndPoint(
            baseURL: baseURLProvider.baseURL,
            token: tokenProvider.token,
            query: query
        )
        return try await cacheFacilitator.executeWithCache(endPoint: endPoint, network: network)
    }
}
