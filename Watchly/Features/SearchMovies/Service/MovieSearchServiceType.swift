//
//  MovieSearchServiceType.swift
//
//
//  Created by Vinsi.
//

import TMDBCore

protocol SearchServiceType {
    func search(query: String, page: Int) async throws -> SearchResultsResponse?
}

struct MovieSearchServiceImpl: SearchServiceType {

    let network: NetworkProcesserType
    let baseURLProvider: BaseURLProvider
    let tokenProvider: TokenProvider
    let cacheFacilitator: EndPointCacheFaciltator<SearchMoviesEndPoint>
    let language: LanguageManager

    func search(query: String, page: Int) async throws -> SearchResultsResponse? {
        guard query.isNotEmpty else {
            return nil
        }
        let endPoint = SearchMoviesEndPoint(
            baseURL: baseURLProvider.baseURL,
            token: tokenProvider.token,
            query: query,
            page: page,
            language: language.selectedLanguage.tmdbLang
        )
        return try await cacheFacilitator.executeWithCache(endPoint: endPoint, network: network)
    }
}
