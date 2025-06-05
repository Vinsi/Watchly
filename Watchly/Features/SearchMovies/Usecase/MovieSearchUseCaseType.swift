//
//  MovieSearchUseCaseType.swift
//
//
//  Created by Vinsi.
//

import TMDBCore

protocol MovieSearchUseCaseType {
    func search(query: String, page: Int) async throws -> SearchResultsResponse
}

struct MovieSearchUseCaseImpl: MovieSearchUseCaseType {

    let service: SearchServiceType
    func search(query: String, page: Int) async throws -> SearchResultsResponse {
        guard let response = try await service.search(query: query, page: page) else {
            throw AppError.emptyValue
        }
        return response
    }
}
