//
//  MovieSearchServiceType.swift
//
//
//  Created by Vinsi.
//

protocol SearchServiceType {
    func search(query: String) async throws -> SearchResultsResponse?
}

struct MovieSearchServiceImpl: SearchServiceType {

    let network: NetworkProcesserType
    let baseURLProvider: BaseURLProvider
    let tokenProvider: TokenProvider

    func search(query: String) async throws -> SearchResultsResponse? {
        defer {
            log.logI("search.query:->['\(query)'].completed")
        }
        log.logW("search.query:->['\(query)'].started")
        guard query.isNotEmpty else {
            return nil
        }
        return try await network.request(from: SearchMoviesEndPoint(baseURL: baseURLProvider.baseURL, token: tokenProvider.token, query: query))
    }
}

// TODO: - Fix me

// struct mockSearchServiceImpl: SearchServiceType {
//    let dictionary: [String: SearchResultsResponse ]
//    func search(query: String) async throws -> SearchResultsResponse {
//        dictionary[query]
//    }
// }
